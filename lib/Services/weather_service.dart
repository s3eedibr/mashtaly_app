import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>?> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    bool? serviceEnabled;
    LocationPermission? permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Location permissions are denied
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied, handle appropriately.
      return null;
    }

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      return null;
    }

    String apiKey = "0a971b7c5266468ab32110003232003";
    String apiUrl =
        "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$latitude,$longitude&aqi=no";

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Weather data successfully retrieved
        Map<String, dynamic> weatherData = jsonDecode(response.body);
        return weatherData;
      } else {
        // Error occurred while fetching weather data
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Handle network errors
      print("Network error: $e");
      return null;
    }
  }
}
