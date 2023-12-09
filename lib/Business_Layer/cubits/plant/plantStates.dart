class PlantState {}

class PlantInitialState extends PlantState {}

class PlantSuccessDataState extends PlantState {
  final String plantName;
  final String imagePath;

  PlantSuccessDataState({
    required this.plantName,
    required this.imagePath,
  });
}

class PlantLoadDataState extends PlantState {}

class PlantGetDataState extends PlantState {}

class PlantNoDataState extends PlantState {}

class PlantErrorState extends PlantState {
  final String error;

  PlantErrorState({required this.error});
}
