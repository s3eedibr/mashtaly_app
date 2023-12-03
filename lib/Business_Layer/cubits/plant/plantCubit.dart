import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../sql.dart';
import 'plantData.dart';
import 'plantStates.dart';

class PlantCubit extends Cubit<PlantState> {
  final SqlDb sqlDb = SqlDb();

  PlantCubit() : super(PlantInitialState());

  addPlant({
    required dynamic imageFile,
    required String plantName,
    required double amountOfWater,
    dynamic from,
    dynamic until,
  }) async {
    try {
      int response;
      response = await sqlDb.insertData('''
        INSERT INTO Plants
        (imagePath, plantName, amountOfWater, type, active, fromDate, untilDate)
        VALUES
        (?, ?, ?, 'New', '1', ?, ?)
        ''', [imageFile, plantName, amountOfWater, from, until]);

      print(response);

      emit(PlantSuccessDataState(
        plants: [], // Since this is addPlant, it may not have plants data immediately
      ));
    } catch (e) {
      emit(PlantErrorState(error: e.toString()));
    }
  }

  fetchAllPlants() async {
    try {
      List<Map<String, dynamic>> plantsData = await sqlDb.getAllPlants();
      List<PlantData> plants = plantsData.map((plantMap) {
        return PlantData.fromMap(plantMap);
      }).toList();

      emit(PlantSuccessDataState(plants: plants));
    } catch (e) {
      emit(PlantErrorState(error: e.toString()));
    }
  }
}
