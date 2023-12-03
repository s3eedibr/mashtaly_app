import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

// Define a class for handling the service related to plant image scanning.
class ScanPlantService {
  // Asynchronous method for sending an image file to the specified API.
  Future<http.Response> sendImageToApi(File imageFile) async {
    // Define the API URL for plant image identification.
    const apiUrl =
        'https://my-api.plantnet.org/v2/identify/all?include-related-images=true&no-reject=true&lang=en&type=kt&api-key=2b10v6ejuzlL3QNTxCILVgcXO';

    // Check the device's internet connectivity.
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection');
    }

    // Create an HTTP client.
    final client = http.Client();
    try {
      // Create a multipart HTTP request for sending the image file.
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add the image file to the request.
      request.files.add(
        await http.MultipartFile.fromPath('images', imageFile.path),
      );

      // Send the request and set a timeout of 30 seconds.
      final response =
          await client.send(request).timeout(const Duration(seconds: 30));

      // Print the status code of the response for debugging purposes.
      print('Response status code: ${response.statusCode}');

      // Return the HTTP response.
      return http.Response.fromStream(response);
    } catch (e) {
      // Throw an exception if there is an error sending the image to the API.
      throw Exception('Error sending image to API: $e');
    } finally {
      // Close the HTTP client to release resources.
      client.close();
    }
  }
}
