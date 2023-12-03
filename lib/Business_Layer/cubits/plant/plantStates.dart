import 'plantData.dart';

class PlantState {}

class PlantInitialState extends PlantState {}

class PlantSuccessDataState extends PlantState {
  final List<PlantData> plants;

  PlantSuccessDataState({
    required this.plants,
  });
}

class SendNotification extends PlantState {}

class PlantGetDataState extends PlantState {}

class PlantNoDataState extends PlantState {}

class PlantErrorState extends PlantState {
  final String error;

  PlantErrorState({required this.error});
}
