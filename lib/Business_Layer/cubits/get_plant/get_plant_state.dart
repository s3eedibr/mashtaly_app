// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_plant_cubit.dart';

@immutable
abstract class GetPlantState {}

class GetPlantInitial extends GetPlantState {}

class GetPlantLoading extends GetPlantState {}

// ignore: must_be_immutable
class GetPlantSuc extends GetPlantState {
  List<PlantModel> myData;
  GetPlantSuc({
    required this.myData,
  });
}

class GetPlantFailure extends GetPlantState {}
