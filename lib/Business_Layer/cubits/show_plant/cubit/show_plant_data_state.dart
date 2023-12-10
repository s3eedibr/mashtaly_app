class ShowPlantState {}

class ShowPlantInitial extends ShowPlantState {}

class ShowPlantNoData extends ShowPlantState {}

class ShowPlantErrorData extends ShowPlantState {}

class ShowPlantLoadData extends ShowPlantState {}

class ShowPlantLoadedData extends ShowPlantState {
  final List<Map<String, dynamic>> myData;

  ShowPlantLoadedData(this.myData);
}
