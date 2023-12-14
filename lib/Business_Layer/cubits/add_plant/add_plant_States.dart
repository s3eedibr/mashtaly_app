class AddPlantState {}

class PlantInitialState extends AddPlantState {}

class PlantSuccessDataState extends AddPlantState {
  final dynamic image,
      currentUserUid,
      plantNameController,
      amountOfWaterController,
      fromDateController,
      untilDateController,
      withSensor;

  PlantSuccessDataState(
    this.image,
    this.currentUserUid,
    this.plantNameController,
    this.amountOfWaterController,
    this.fromDateController,
    this.untilDateController,
    this.withSensor,
  );
}

class PlantNoDataState extends AddPlantState {}

class PlantLoadingState extends AddPlantState {}

class UpdatePlantScreen extends AddPlantState {
  final List<Map<String, dynamic>> myData;
  UpdatePlantScreen({
    required this.myData,
  });
}

class PlantErrorState extends AddPlantState {
  final String error;

  PlantErrorState(
    this.error,
  );
}
