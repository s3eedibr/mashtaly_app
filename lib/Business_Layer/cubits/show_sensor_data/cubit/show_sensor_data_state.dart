part of 'show_sensor_data_cubit.dart';

@immutable
class ShowSensorDataState {}

class ShowSensorDataInitial extends ShowSensorDataState {
  final double percentage;

  ShowSensorDataInitial(this.percentage);
}

class ShowSensorLoadingData extends ShowSensorDataState {}
