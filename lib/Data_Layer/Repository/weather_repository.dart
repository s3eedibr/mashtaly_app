import 'package:geolocator/geolocator.dart';
import 'package:mashtaly_app/Data_Layer/Model/weather/current.dart';

import '../../Constants/text_strings.dart';
import '../Api/weather_api.dart';

class WeatherRepository {
  final WeatherApi apiClient = WeatherApi(
    apiKey: tWeatherApiKey,
    baseUrl: tWeatherApi,
  );

  WeatherRepository() {
    // Initialize the WeatherApi client with the provided API key and base URL.
    apiClient;
  }

  Future<Current?> fetchWeatherData(
      {required double latitude, required double longitude}) async {
    bool? serviceEnabled;
    LocationPermission? permission;

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are disabled, return null.
        return null;
      }

      // Check location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // Location permissions are denied, return null.
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Location permissions are permanently denied, handle appropriately.
        return null;
      }

      // Fetch weather data using the API client
      final weatherData = await apiClient.fetchWeatherData(latitude, longitude);

      // Parse the weather data and return the result
      return Current.fromJson(weatherData as Map<String, dynamic>);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
