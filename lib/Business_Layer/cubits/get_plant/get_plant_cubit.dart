import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../Presentation_Layer/Screen/Plant/plantModel.dart';

part 'get_plant_state.dart';

class GetPlantCubit extends Cubit<GetPlantState> {
  GetPlantCubit() : super(GetPlantInitial());

  CollectionReference userPlantsRef = FirebaseFirestore.instance
      .collection('myPlants')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('MyPlants');

  void getPlant() {
    List<PlantModel> myData = [];
    try {
      emit(GetPlantLoading());
      userPlantsRef.snapshots().listen(
        (event) {
          for (var plant in event.docs) {
            myData.add(
              PlantModel(
                // active: plant['active'],
                // amountOfWater: plant['amountOfWater'],
                // date: plant['date'],
                // from: plant['from'],
                // id: plant['id'],
                myPlantPic1: plant['myPlant_pic1'],
                plantName: plant['plantName'],
                // schedule: List<Map<String, dynamic>>.from(plant['schedule']),
                // sensor: plant['sensor'],
                // until: plant['until'],
                // userId: plant['user_id'],
                // weatherConditionsAndDurations: List<Map<String, dynamic>>.from(
                //     plant['weatherConditionsAndDurations']),
              ),
            );
            print(plant);
          }
          emit(GetPlantSuc(myData: myData));
        },
      );
    } catch (e) {
      emit(GetPlantFailure());
    }
  }
}
