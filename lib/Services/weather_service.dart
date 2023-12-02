import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>?> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) return null;
      }

      if (permission == LocationPermission.deniedForever) return null;

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) return null;

      const String apiKey = "0a971b7c5266468ab32110003232003";
      final String apiUrl =
          "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=${Uri.encodeComponent('$latitude,$longitude')}&aqi=no";

      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> weatherData = jsonDecode(response.body);
        return weatherData;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Network error: $e");
      return null;
    }
  }
}
