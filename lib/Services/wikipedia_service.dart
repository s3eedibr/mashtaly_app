import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

// Asynchronous function to fetch plant information based on the provided plant name and common name.
Future<String> fetchPlantInformation(
    String plantName, String commonName) async {
  // Define the Wikipedia API URL for fetching information based on the plant name.
  final apiUrl =
      'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=$plantName&prop=extracts&exintro=True&explaintext=True';

  // Call the internal function to perform the actual information retrieval.
  return _fetchPlantInformation(apiUrl, plantName, commonName);
}

// Asynchronous function to fetch plant information based on the provided common name.
Future<String> fetchPlantInformationCommonName(
    String plantName, String commonName) async {
  // Define the Wikipedia API URL for fetching information based on the common name.
  final apiUrl =
      'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=$commonName&prop=extracts&exintro=True&explaintext=True';

  // Call the internal function to perform the actual information retrieval.
  return _fetchPlantInformation(apiUrl, plantName, commonName);
}

// Internal function to fetch plant information from Wikipedia using the provided API URL.
Future<String> _fetchPlantInformation(
    String apiUrl, String plantName, String commonName) async {
  // Check the device's internet connectivity.
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return 'No internet connection';
  }

  // Make an HTTP GET request to the Wikipedia API.
  final response = await http.get(Uri.parse(apiUrl));

  // Check if the response status code is 200 (OK).
  if (response.statusCode == 200) {
    // Decode the JSON response.
    final data = json.decode(response.body);

    // Check if the expected keys ('query' and 'pages') exist in the response.
    if (data.containsKey('query') &&
        data['query'] != null &&
        data['query'].containsKey('pages')) {
      // Extract information from the response.
      final pages = data['query']['pages'];
      final pageId = pages.keys.first;
      final pageData = pages[pageId];
      final pageExtract = pageData['extract'];

      // If the plant name is not found, use the common name instead.
      if (pageExtract == null || pageExtract.isEmpty) {
        return fetchPlantInformationCommonName(plantName, commonName);
      }
      return pageExtract;
    } else {
      // Handle the case where the expected keys are not present in the response.
      return 'Invalid response format';
    }
  } else {
    // Throw an exception if the response status code is not 200.
    throw Exception('Failed to fetch plant information');
  }
}
