import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherService weather = WeatherService();
  double? latitude;
  double? longitude;
  String weatherText = '';
  String temperature = '';
  String icon = '';
  String wind = '';
  String humidity = '';
  String cloud = '';
  Timer? timer;
  LocationPermission? permission;

  Future<void> getLocationAndFetchWeather() async {
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude = position.latitude;
    longitude = position.longitude;
    startTimer();
    getWeatherData();
    notifyListeners();
  }

  void getWeatherData() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      if (latitude != null && longitude != null) {
        Map<String, dynamic>? weatherData = await weather.getWeather(
          latitude: latitude!,
          longitude: longitude!,
        );
        if (weatherData != null) {
          weatherText = weatherData['current']['condition']['text'];
          temperature = weatherData['current']['temp_c'].toString();
          String iconPath = weatherData['current']['condition']['icon'];
          icon = 'http:$iconPath';
          wind = weatherData['current']['wind_kph'].toString();
          humidity = weatherData['current']['humidity'].toString();
          cloud = weatherData['current']['cloud'].toString();
        }
        notifyListeners();
      }
    } else {
      print('No internet connection');
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(minutes: 30), (Timer t) {
      getWeatherData();
    });
    getWeatherData();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
