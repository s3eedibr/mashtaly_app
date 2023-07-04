import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:gallery_saver/gallery_saver.dart';
import 'package:mashtaly_app/Constants/colors.dart';

class CameraScanner extends StatefulWidget {
  const CameraScanner({Key? key}) : super(key: key);

  @override
  _CameraScannerState createState() => _CameraScannerState();
}

class _CameraScannerState extends State<CameraScanner> {
  late CameraController _cameraController;
  late Future<void> _cameraInitialization;
  bool _isCapturing = false;
  bool _isCameraAvailable = true;

  @override
  void initState() {
    super.initState();
    _cameraInitialization = initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Scan Object",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _cameraInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 18.0),
                ),
              );
            } else {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: CameraPreview(_cameraController)),
                  Image.asset(
                    'assets/images/stack_images/Group 223.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 355),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Please make sure your object is in\nthe square",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Powered by",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 12,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //       SizedBox(
                  //         width: 5,
                  //       ),
                  //       Image.asset(
                  //         'assets/images/icons/plantnet.png',
                  //         height: 14,
                  //         width: 80,
                  //       )
                  //     ],
                  //   )
                ],
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 343,
        child: FloatingActionButton.extended(
          onPressed: _isCapturing ? null : takePhotoAndSendToApi,
          backgroundColor: tPrimaryActionColor,
          label: Text(
            'Scan Plant',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> takePhotoAndSendToApi() async {
    if (!_cameraController.value.isInitialized ||
        _isCapturing ||
        !_isCameraAvailable) {
      return;
    }

    setState(() {
      _isCapturing = true;
      _isCameraAvailable = false;
    });

    try {
      final image = await _cameraController.takePicture();
      final imageFile = File(image.path);

      // Save the image to the gallery
      await GallerySaver.saveImage(imageFile.path,
          albumName: 'Mashtaly | Scan Plant');

      // Send the image file to the API
      final response = await sendImageToApi(imageFile);

      // Process the response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Process the received data
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error capturing photo: $e');
    } finally {
      setState(() {
        _isCapturing = false;
        _isCameraAvailable = true;
      });
    }
  }

  Future<http.Response> sendImageToApi(File imageFile) async {
    const apiUrl =
        'https://my-api.plantnet.org/v2/identify/all?api-key=2b10v6ejuzlL3QNTxCILVgcXO&';
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.files.add(
      await http.MultipartFile.fromPath('images', imageFile.path),
    );

    final response = await request.send();
    return http.Response.fromStream(response);
  }
}
