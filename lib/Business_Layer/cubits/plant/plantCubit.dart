import 'package:flutter_bloc/flutter_bloc.dart';
import 'plantStates.dart';

class PlantCubit extends Cubit<PlantState> {
  PlantCubit() : super(PlantInitialState());

  addPlant({
    imageFile,
    required plantName,
    required amountOfWater,
    from,
    until,
  }) async {
    // SqlDb sqlDb = SqlDb();

    try {
      //   int response;
      //   response = await sqlDb.insertData('''
      //       "INSERT INTO 'Plants'
      //       ('imagePath','plantName','amountOfWater','type','active','fromDate','untilDate')
      //       VALUES
      //       ($imageUrl,$plantName,$amountOfWater,'New','1',$from, $until,''');
      //   print(response);
      //   PlantCard(
      //     plantName: plantName,
      //   );
      emit(PlantSuccessDataState(
        plantName: plantName,
        imageFile: imageFile,
      ));
    } catch (e) {
      emit(PlantErrorState(error: e.toString()));
    }
  }
}
