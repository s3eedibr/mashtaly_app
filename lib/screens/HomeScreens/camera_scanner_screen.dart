import 'package:flutter/material.dart';

import '../../Constants/colors.dart';

class CameraScanner extends StatefulWidget {
  const CameraScanner({super.key});

  @override
  State<CameraScanner> createState() => _CameraScannerState();
}

class _CameraScannerState extends State<CameraScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      body: Center(
        child: Text(
          "Camera Scanner",
          style: TextStyle(fontSize: 35),
        ),
      ),
    );
  }
}
