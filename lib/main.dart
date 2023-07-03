import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashtaly_app/Constants/colors.dart';
import 'package:mashtaly_app/Screens/OnboradingScreen/onboarding_screen.dart';
import 'package:mashtaly_app/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/auth.dart';

int? isViewed;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Mulish',
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: tPrimaryActionColor.withOpacity(.5),
          cursorColor: tPrimaryActionColor.withOpacity(.6),
          selectionHandleColor: tPrimaryActionColor.withOpacity(1),
        ),
      ),
      home: isViewed != 0 ? const OnBoardingScreen() : const Auth(),
    );
  }
}
