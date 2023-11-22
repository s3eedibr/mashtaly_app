import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class ScanPlantService {
  Future<http.Response> sendImageToApi(File imageFile) async {
    const apiUrl =
        'https://my-api.plantnet.org/v2/identify/all?include-related-images=true&no-reject=true&lang=en&type=kt&api-key=2b10v6ejuzlL3QNTxCILVgcXO';

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection');
    }

    final client = http.Client();
    try {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.files.add(
        await http.MultipartFile.fromPath('images', imageFile.path),
      );

      final response = await client.send(request);
      return http.Response.fromStream(response);
    } catch (e) {
      throw Exception('Error sending image to API: $e');
    } finally {
      client.close();
    }
  }
}
