import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Presentation_Layer/Screen/HomeScreens/home_screen.dart';
import 'auth_screen.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // Use Firebase Auth to listen to authentication state changes.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // If the user is authenticated, show the HomeScreen.
            return const HomeScreen();
          } else {
            // If the user is not authenticated, show the AuthScreen.
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
