import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../sql.dart';
import 'plantStates.dart';

class PlantCubit extends Cubit<PlantState> {
  // final SqlDb sqlDb = SqlDb();

  PlantCubit() : super(PlantInitialState());

  addPlant({
    required dynamic imageFile,
    required String plantName,
    required double amountOfWater,
    dynamic from,
    dynamic until,
  }) async {
    try {
      // int response;
      // response = await sqlDb.insertData('''
      //   INSERT INTO Plants
      //   (imagePath, plantName, amountOfWater, type, active, fromDate, untilDate)
      //   VALUES
      //   (?, ?, ?, 'New', '1', ?, ?)
      //   ''', [imageFile, plantName, amountOfWater, from, until]);

      // print(response);

      emit(PlantSuccessDataState(imagePath: imageFile, plantName: plantName));
    } catch (e) {
      emit(PlantErrorState(error: e.toString()));
    }
  }
}
