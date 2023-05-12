import 'package:flutter/material.dart';

import '../Screens/Authentication/login_screen.dart';
import '../Screens/Authentication/reg_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLoginScreen = true;

  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        showRegScreen: toggleScreen,
      );
    } else {
      return RegistrationScreen(
        showLoginScreen: toggleScreen,
      );
    }
  }
}
