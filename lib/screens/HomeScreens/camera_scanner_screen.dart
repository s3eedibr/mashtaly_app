import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:mashtaly_app/Constants/colors.dart';

import '../../Services/scan_plant_service.dart';

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
  final ScanPlantService _scanPlantService = ScanPlantService();
  String plantName = '';

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
      await GallerySaver.saveImage(imageFile.path, albumName: 'Mashtaly');

      // Send the image file to the API
      final response = await _scanPlantService.sendImageToApi(imageFile);

      // Process the response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        plantName = responseData['bestMatch'];
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
                    'assets/images/stack_images/Group 2266.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 360),
                    child: Text(
                      "Please make sure your object is in\nthe square",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
          } else {
            // Show a loading indicator while initializing the camera
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/plant_loading2.gif",
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Mulish',
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 343,
        child: FloatingActionButton.extended(
          backgroundColor: tPrimaryActionColor,
          onPressed: () {
            if (_isCapturing) {
              return null;
            } else {
              takePhotoAndSendToApi();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Theme(
                        data: ThemeData(
                          dialogBackgroundColor:
                              Colors.white, // Set the background color to white
                        ),
                        child: FutureBuilder(
                            future: Future.delayed(Duration(seconds: 5)),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // Show a loading indicator while waiting
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/plant_loading2.gif",
                                        height: 100,
                                        width: 100,
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Loading...',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Mulish',
                                          decoration: TextDecoration.none,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  icon: const Icon(
                                    Icons.check_rounded,
                                    color: tPrimaryActionColor,
                                    size: 56,
                                  ),
                                  title: const SizedBox(
                                    height: 55,
                                    child: Text(
                                      "Scan Object Success",
                                      style: TextStyle(
                                          color: tPrimaryActionColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Name:',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              plantName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Text.rich(
                                          TextSpan(
                                            text:
                                                "See more information about this",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: " plant.",
                                                style: TextStyle(
                                                  color: tThirdTextErrorColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, bottom: 0, left: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 45,
                                            width: 120,
                                            child: OutlinedButton(
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                  color: tPrimaryActionColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                side: const BorderSide(
                                                  color: tPrimaryActionColor,
                                                  width: 1,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            width: 120,
                                            child: ElevatedButton(
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    tPrimaryActionColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                  actionsPadding: EdgeInsets.only(bottom: 15),
                                );
                              }
                            }),
                      ));
            }
          },
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
}
