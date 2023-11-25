import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'Animations/splash_screen.dart';
import 'Auth/auth.dart';
import 'Constants/colors.dart';
import 'Presentation_Layer/Screen/OnboradingScreen/onboarding_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  Connectivity().checkConnectivity();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? isViewed =
      prefs.getInt('onBoard'); // Check if onboarding has been viewed.

  // Run the app by displaying the splash screen.
  runApp(SplashScreenApp(
    isViewed: isViewed,
  ));
}

class SplashScreenApp extends StatelessWidget {
  final int? isViewed;

  const SplashScreenApp({super.key, required this.isViewed});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        onSplashFinished: () {
          runApp(App(
            isViewed: isViewed,
          ));
        },
      ),
    );
  }
}

class App extends StatelessWidget {
  final int? isViewed;

  App({super.key, required this.isViewed});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Mulish',
        useMaterial3: true,
        dialogBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: tPrimaryActionColor.withOpacity(.5),
          cursorColor: tPrimaryActionColor.withOpacity(.6),
          selectionHandleColor: tPrimaryActionColor.withOpacity(1),
        ),
      ),

      // Show OnBoardingScreen if it hasn't been viewed, otherwise show Auth
      home: isViewed != 0 ? const OnBoardingScreen() : const Auth(),
    );
  }
}
