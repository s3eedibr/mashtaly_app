import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';

import '../../../Services/weather_service.dart';
import 'weatherStates.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weather = WeatherService();
  double? latitude;
  double? longitude;
  Timer? timer;
  LocationPermission? permission;

  WeatherCubit() : super(WeatherInitialState());

  Future<void> getLocationAndFetchWeather() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      permission = await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      try {
        Map<String, dynamic>? weatherData = await weather.getWeather(
          latitude: latitude!,
          longitude: longitude!,
        );

        if (weatherData != null) {
          final current = weatherData['current'];
          if (current != null) {
            final condition = current['condition'];
            if (condition != null) {
              emit(WeatherDataState(
                weatherText: condition['text'] ?? '',
                temperature: current['temp_c'].toString(),
                icon: 'http:${condition['icon']}',
                wind: current['wind_kph'].toString(),
                humidity: current['humidity'].toString(),
                cloud: current['cloud'].toString(),
              ));
            }
          }
        }
      } catch (e) {
        emit(WeatherErrorState(error: 'Failed to get weather data.'));
      }
    } else {
      emit(WeatherErrorState(error: 'No internet connection.'));
    }
  }

  // Future<void> getWeatherData() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult != ConnectivityResult.none) {
  //     if (latitude != null && longitude != null) {
  //       try {
  //         Map<String, dynamic>? weatherData = await weather.getWeather(
  //           latitude: latitude!,
  //           longitude: longitude!,
  //         );

  //         if (weatherData != null) {
  //           final current = weatherData['current'];
  //           if (current != null) {
  //             final condition = current['condition'];
  //             if (condition != null) {
  //               emit(WeatherDataState(
  //                 weatherText: condition['text'] ?? '',
  //                 temperature: current['temp_c'].toString(),
  //                 icon: 'http:${condition['icon']}',
  //                 wind: current['wind_kph'].toString(),
  //                 humidity: current['humidity'].toString(),
  //                 cloud: current['cloud'].toString(),
  //               ));
  //             }
  //           }
  //         }
  //       } catch (e) {
  //         emit(WeatherErrorState(error: 'Failed to get weather data.'));
  //       }
  //     }
  //   } else {
  //     emit(WeatherErrorState(error: 'No internet connection.'));
  //   }
  // }

  void startTimer() {
    timer = Timer.periodic(const Duration(minutes: 30), (Timer t) {
      getLocationAndFetchWeather();
    });
    getLocationAndFetchWeather();
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
