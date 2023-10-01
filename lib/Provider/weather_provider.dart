import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

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
  LocationPermission? permission;
  Timer? timer;

  // Get the user's location and fetch weather data.
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

  // Retrieve weather data based on location.
  void getWeatherData() async {
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
  }

  // Start a timer to periodically fetch weather data.
  void startTimer() {
    timer = Timer.periodic(const Duration(minutes: 30), (Timer t) {
      getWeatherData();
    });
    getWeatherData(); // Fetch data immediately when the app starts
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
