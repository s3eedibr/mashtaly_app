import 'package:flutter/material.dart';

import '../Presentation_Layer/Screen/Authentication/login_screen.dart';
import '../Presentation_Layer/Screen/Authentication/reg_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // A boolean variable to track whether to show the login screen or registration screen.
  bool showLoginScreen = true;

  // Function to toggle between the login and registration screens.
  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      // Show the LoginScreen and pass the toggle function to switch to the registration screen.
      return LoginScreen(
        showRegScreen: toggleScreen,
      );
    } else {
      // Show the RegistrationScreen and pass the toggle function to switch to the login screen.
      return RegistrationScreen(
        showLoginScreen: toggleScreen,
      );
    }
  }
}
