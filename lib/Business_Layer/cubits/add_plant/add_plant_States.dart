class PlantState {}

class PlantInitialState extends PlantState {}

class PlantLoadDataState extends PlantState {}

class PlantSuccessDataState extends PlantState {
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

class PlantNoDataState extends PlantState {}

class PlantErrorState extends PlantState {
  final String error;

  PlantErrorState(
    this.error,
  );
}
