import 'package:flutter/material.dart';

import '../Auth/auth.dart';
import '../Constants/colors.dart';
import '../Constants/image_strings.dart';
import '../Screens/OnboradingScreen/onboarding_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

int? isViewed;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// void change() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   isViewed = prefs.getInt('onBoard');
// }

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then(
      (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return isViewed != 0 ? OnBoardingScreen() : const Auth();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: tBgColor,
              child: Image.asset(
                tLogo,
              ),
            ),
            Text(
              "Mashtaly",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: tPrimaryActionColor,
              ),
            ),
            SizedBox(height: 50),
            SpinKitThreeBounce(
              color: tPrimaryActionColor,
              size: 30,
            )
          ],
        ),
      ),
    ));
  }
}
