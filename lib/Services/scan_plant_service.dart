import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

// Define a class for handling the service related to plant image scanning.
class ScanPlantService {
  Future<http.Response> sendImageToApi(File imageFile) async {
    const apiUrl =
        'https://my-api.plantnet.org/v2/identify/all?include-related-images=true&no-reject=true&lang=en&type=kt&api-key=2b10v6ejuzlL3QNTxCILVgcXO';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection');
      }

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files
          .add(await http.MultipartFile.fromPath('images', imageFile.path));

      var response = await request.send().timeout(const Duration(seconds: 30));

      print('Response status code: ${response.statusCode}');
      return http.Response.fromStream(response);
    } catch (e) {
      throw Exception('Error sending image to API: $e');
    }
  }
}
