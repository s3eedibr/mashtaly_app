import 'package:flutter/material.dart';
import '../Constants/assets.dart';

import '../Constants/colors.dart';

class SplashScreen extends StatefulWidget {
  final Function onSplashFinished;

  const SplashScreen({Key? key, required this.onSplashFinished})
      : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 8 seconds before triggering the onSplashFinished callback.
    Future.delayed(const Duration(seconds: 8)).then(
      (value) {
        // Call the callback function to notify that the splash screen is finished.
        widget.onSplashFinished();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.assetsImagesLogo,
              height: 200,
              width: 200,
            ),
            const Text(
              "Mashtaly",
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Mulish',
                fontWeight: FontWeight.bold,
                color: tPrimaryTextColor,
              ),
            ),
            Image.asset(
              Assets.assetsImagesEllipsis2s151px,
              height: 85,
              width: 85,
            )
          ],
        ),
      ),
    );
  }
}
