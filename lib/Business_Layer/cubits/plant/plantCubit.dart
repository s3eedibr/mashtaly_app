import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Plant/Widget/plant_card.dart';
import 'plantStates.dart';

class PlantCubit extends Cubit<PlantState> {
  PlantCubit() : super(PlantNoDataState());

  addPlant({
    required dynamic imageFile,
    required String plantName,
  }) async {
    try {
      PlantCard(
        plantName: plantName,
        imageFile: imageFile,
      );
      emit(PlantSuccessDataState(imagePath: imageFile, plantName: plantName));
    } catch (e) {
      emit(PlantErrorState(error: e.toString()));
    }
  }
}
