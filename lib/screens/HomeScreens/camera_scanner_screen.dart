import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mashtaly_app/Constants/colors.dart';
import 'package:mashtaly_app/Screens/PlantScreens/plants_info_screen.dart';

import '../../Animations/waiting_screen.dart';
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
  String commonName = '';
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
        plantName = responseData['results'][0]['species']
            ['scientificNameWithoutAuthor'];
        commonName = responseData['results'][0]['species']['commonNames'][0];
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

  Future<void> choosePhotoFromGallery() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final imageFile = File(image.path);
    sendPhotoToApi(imageFile);

    showDialog(
      context: context,
      builder: (BuildContext context) => Theme(
        data: ThemeData(
          dialogBackgroundColor: Colors.white,
        ),
        child: FutureBuilder(
          future: Future.delayed(
            Duration(seconds: 7),
          ),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while waiting
              return WaitingScreen();
            } else {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                icon: plantName.isNotEmpty
                    ? Icon(
                        Icons.check_rounded,
                        color: tPrimaryActionColor,
                        size: 56,
                      )
                    : Icon(
                        Icons.question_mark_rounded,
                        color: tThirdTextErrorColor,
                        size: 56,
                      ),
                title: plantName.isNotEmpty
                    ? SizedBox(
                        height: 35,
                        child: Text(
                          "Scan Object Success",
                          style: TextStyle(
                              color: tPrimaryActionColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : SizedBox(
                        height: 35,
                        child: Text(
                          "Scan Object Unsuccess",
                          style: TextStyle(
                              color: tThirdTextErrorColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                content: plantName.isNotEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Name: ',
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Common Name: ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  commonName,
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
                                text: "See more information about this",
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
                      )
                    : const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Please scan again',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                actions: [
                  plantName.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                              right: 16, bottom: 0, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      borderRadius: BorderRadius.circular(12),
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
                                    backgroundColor: tPrimaryActionColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PlantsInfoScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            height: 45,
                            width: 120,
                            child: OutlinedButton(
                              child: Text(
                                'Ok',
                                style: TextStyle(
                                  color: tThirdTextErrorColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  color: tThirdTextErrorColor,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        )
                ],
                actionsPadding: EdgeInsets.only(bottom: 15),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> sendPhotoToApi(File imageFile) async {
    setState(() {
      _isCapturing = true;
      _isCameraAvailable = false;
    });

    try {
      final response = await _scanPlantService.sendImageToApi(imageFile);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        plantName = responseData['results'][0]['species']
            ['scientificNameWithoutAuthor'];
        commonName = responseData['results'][0]['species']['commonNames'][0];
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending photo to API: $e');
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
            return WaitingScreen();
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 280,
            child: FloatingActionButton.extended(
              heroTag: 'btn1',
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
                        future: Future.delayed(Duration(seconds: 7)),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Show a loading indicator while waiting
                            return WaitingScreen();
                          } else {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              icon: plantName.isNotEmpty
                                  ? Icon(
                                      Icons.check_rounded,
                                      color: tPrimaryActionColor,
                                      size: 56,
                                    )
                                  : Icon(
                                      Icons.question_mark_rounded,
                                      color: tThirdTextErrorColor,
                                      size: 56,
                                    ),
                              title: plantName.isNotEmpty
                                  ? SizedBox(
                                      height: 35,
                                      child: Text(
                                        "Scan Object Success",
                                        style: TextStyle(
                                            color: tPrimaryActionColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 35,
                                      child: Text(
                                        "Scan Object Unsuccess",
                                        style: TextStyle(
                                            color: tThirdTextErrorColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                              content: plantName.isNotEmpty
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Name: ',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                plantName,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Common Name: ',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                commonName,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                    )
                                  : const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Please scan again',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                              actions: [
                                plantName.isNotEmpty
                                    ? Padding(
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
                                                        BorderRadius.circular(
                                                            12),
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
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PlantsInfoScreen(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: SizedBox(
                                          height: 45,
                                          width: 120,
                                          child: OutlinedButton(
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(
                                                color: tThirdTextErrorColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                color: tThirdTextErrorColor,
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
                                      )
                              ],
                              actionsPadding: EdgeInsets.only(bottom: 15),
                            );
                          }
                        },
                      ),
                    ),
                  );
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
          const SizedBox(width: 10),
          SizedBox(
            height: 50,
            width: 55,
            child: FloatingActionButton.extended(
              heroTag: 'btn2',
              backgroundColor: tPrimaryActionColor,
              onPressed: () {
                choosePhotoFromGallery();
              },
              label: FaIcon(
                FontAwesomeIcons.image,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
