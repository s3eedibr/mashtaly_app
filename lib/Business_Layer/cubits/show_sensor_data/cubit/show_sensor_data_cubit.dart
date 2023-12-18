import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'show_sensor_data_state.dart';

class ShowSensorDataCubit extends Cubit<ShowSensorDataState> {
  ShowSensorDataCubit() : super(ShowSensorDataInitial(0.0));

  Future<void> loadData(String userId) async {
    try {
      emit(ShowSensorLoadingData());
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('users/$userId/measurement').get();

      emit(ShowSensorLoadingData());
      if (snapshot.exists) {
        var sensorData = snapshot.value;

        if (sensorData is int) {
          // If the value is an integer, convert it to double
          double doubleValue = sensorData.toDouble();
          log('${doubleValue.toString()}================================ from cubit');
          emit(ShowSensorDataInitial(doubleValue));
        } else if (sensorData is double) {
          // If the value is already a double, use it directly
          emit(ShowSensorDataInitial(sensorData));
        } else {
          print('Invalid data type: ${sensorData.runtimeType}');
        }
      } else {
        print('No data available.');
      }
    } catch (e) {
      print(e);
    }
  }
}
