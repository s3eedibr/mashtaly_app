import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// Define a class for handling weather-related services.
class WeatherService {
  // Asynchronous method for retrieving weather data based on latitude and longitude.
  Future<Map<String, dynamic>?> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Check if location services are enabled on the device.
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      // Check the permission status for accessing location.
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permission if not granted and exit if permission is still denied.
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) return null;
      }

      // Exit if location permission is permanently denied.
      if (permission == LocationPermission.deniedForever) return null;

      // Check the device's internet connectivity.
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) return null;

      // Define API key and URL for the weather service.
      const String apiKey = "0a971b7c5266468ab32110003232003";
      final String apiUrl =
          "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=${Uri.encodeComponent('$latitude,$longitude')}&aqi=no";

      // Make an HTTP GET request to the weather API.
      http.Response response = await http.get(Uri.parse(apiUrl));

      // Check if the response status code is 200 (OK).
      if (response.statusCode == 200) {
        // Decode the JSON response and return the weather data.
        Map<String, dynamic> weatherData = jsonDecode(response.body);
        return weatherData;
      } else {
        // Print an error message if the response status code is not 200.
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Print an error message for any network-related exceptions.
      print("Network error: $e");
      return null;
    }
  }
}
