import 'package:flutter_bloc/flutter_bloc.dart';
import 'plantStates.dart';

class PlantCubit extends Cubit<PlantState> {
  PlantCubit() : super(PlantInitialState());

  addPlant({
    required plantName,
    required amountOfWater,
    from,
    until,
    delayWatering,
    schedule,
  }) {
    emit(SuccessPlantDataState());
  }
}
