import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/weather/current.dart';

class WeatherApi {
  final String apiKey;
  final String baseUrl;

  WeatherApi({required this.apiKey, required this.baseUrl});

  Future<List<Current>> fetchWeatherData(
      double latitude, double longitude) async {
    try {
      // Construct the API URL with the provided latitude and longitude.
      final apiUrl = '$baseUrl?key=$apiKey&q=$latitude,$longitude&aqi=no';

      // Make an HTTP GET request to the API endpoint.
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the response status code is 200 (OK), parse and return the weather data.
        final List result = jsonDecode(response.body)['current'];
        return result.map((e) => Current.fromJson(e)).toList();
      } else {
        // If the response status code is not 200, throw an exception.
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      // Handle any exceptions that may occur, print an error message, and re-throw.
      print('Error: $e');
      throw Exception('Failed to fetch weather data');
    }
  }
}
