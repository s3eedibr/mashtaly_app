import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> fetchPlantInformation(
    String plantName, String commonName) async {
  final apiUrl =
      'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=$plantName&prop=extracts&exintro=True&explaintext=True';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final pages = data['query']['pages'];
    final pageId = pages.keys.first;
    final pageData = pages[pageId];
    final pageExtract = pageData['extract'];

    // If the plant name is not found, use the common name instead
    if (pageExtract == null || pageExtract.isEmpty) {
      return fetchPlantInformationCommonName(plantName, commonName);
    }
    return pageExtract;
  } else {
    throw Exception('Failed to fetch plant information');
  }
}

Future<String> fetchPlantInformationCommonName(
    String plantName, String commonName) async {
  final apiUrl =
      'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=$commonName&prop=extracts&exintro=True&explaintext=True';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final pages = data['query']['pages'];
    final pageId = pages.keys.first;
    final pageData = pages[pageId];
    final pageExtract = pageData['extract'];

    // If the plant name is not found, use the common name instead
    if (pageExtract == null || pageExtract.isEmpty) {
      return 'No information found for $plantName. Here is information for $commonName instead.';
    }
    return pageExtract;
  } else {
    throw Exception('Failed to fetch plant information');
  }
}
