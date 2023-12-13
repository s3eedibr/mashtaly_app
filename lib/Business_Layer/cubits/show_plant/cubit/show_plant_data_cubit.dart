import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Presentation_Layer/Screen/Plant/Data/getData.dart';
import 'show_plant_data_state.dart';

class ShowPlantCubit extends Cubit<ShowPlantState> {
  ShowPlantCubit() : super(ShowPlantInitial());

  Future<void> loadData(String userId) async {
    try {
      emit(ShowPlantLoadData());

      // Fetch data from Firestore using the getMyPlants function
      final myData = await getMyPlants(userId);

      if (myData.isEmpty) {
        emit(ShowPlantNoData());
      } else {
        emit(ShowPlantSucData(myData));
      }
    } catch (e) {
      print('Error loading data: $e');
      emit(ShowPlantNoData());
    }
  }
}
