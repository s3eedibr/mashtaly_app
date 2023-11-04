import 'package:geolocator/geolocator.dart';

import '../../Constants/text_strings.dart';
import '../Api/weather_api.dart';
import '../Model/weather/weather.dart';

class WeatherRepository {
  final WeatherApi apiClient = WeatherApi(
    apiKey: tWeatherApiKey,
    baseUrl: tWeatherApi,
  );

  WeatherRepository() {
    // Initialize the WeatherApi client with the provided API key and base URL.
    apiClient;
  }

  Future<Weather?> fetchWeatherData(
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
      return Weather.fromJson(weatherData);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
