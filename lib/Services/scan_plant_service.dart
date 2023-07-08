import 'dart:io';

import 'package:http/http.dart' as http;

class ScanPlantService {
  Future<http.Response> sendImageToApi(File imageFile) async {
    const apiUrl =
        'https://my-api.plantnet.org/v2/identify/all?include-related-images=true&no-reject=true&lang=en&type=kt&api-key=2b10v6ejuzlL3QNTxCILVgcXO';
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.files.add(
      await http.MultipartFile.fromPath('images', imageFile.path),
    );

    final response = await request.send();
    return http.Response.fromStream(response);
  }
}
