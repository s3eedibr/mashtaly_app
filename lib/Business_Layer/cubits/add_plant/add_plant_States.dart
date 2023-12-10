class AddPlantState {}

class PlantInitialState extends AddPlantState {}

class PlantLoadDataState extends AddPlantState {}

class PlantSuccessDataState extends AddPlantState {
  final dynamic image,
      currentUserUid,
      plantNameController,
      amountOfWaterController,
      fromDateController,
      untilDateController;

  PlantSuccessDataState(
    this.image,
    this.currentUserUid,
    this.plantNameController,
    this.amountOfWaterController,
    this.fromDateController,
    this.untilDateController,
  );
}

class PlantNoDataState extends AddPlantState {}

class PlantErrorState extends AddPlantState {
  final String error;

  PlantErrorState(
    this.error,
  );
}
