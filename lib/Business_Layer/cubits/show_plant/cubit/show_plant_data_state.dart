class ShowPlantState {}

class ShowPlantInitial extends ShowPlantState {}

class ShowPlantNoData extends ShowPlantState {}

class ShowPlantErrorData extends ShowPlantState {}

class ShowPlantLoadData extends ShowPlantState {}

class ShowPlantSucData extends ShowPlantState {
  final List<Map<String, dynamic>> myData;

  ShowPlantSucData(this.myData);
}
