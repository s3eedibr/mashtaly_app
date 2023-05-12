import 'package:flutter/material.dart';
import 'package:mashtaly_app/screens/login_screen.dart';
import 'package:mashtaly_app/screens/reg_screen.dart';

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
