class PlantState {}

class PlantInitialState extends PlantState {}

class PlantUpdateDataState extends PlantState {}

class PlantSuccessDataState extends PlantState {
  final String plantName;
  final String imageFile;

  PlantSuccessDataState({
    required this.imageFile,
    required this.plantName,
  });
}

class SendNotification extends PlantState {}

class PlantGetDataState extends PlantState {}

class PlantNoDataState extends PlantState {}

class PlantErrorState extends PlantState {
  final String error;

  PlantErrorState({required this.error});
}
