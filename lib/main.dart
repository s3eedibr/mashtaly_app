import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Animations/splash_screen.dart';
import 'Auth/auth.dart';
import 'Business_Layer/cubit/weather_cubit.dart';
import 'Constants/colors.dart';
import 'Data_Layer/Repository/weather_repository.dart';
import 'Presentation_Layer/Screen/OnboradingScreen/onboarding_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? isViewed = prefs.getInt('onBoard');

  // Create an instance of WeatherRepository and pass it to WeatherCubit
  final WeatherRepository weatherRepository = WeatherRepository();
  final WeatherCubit weatherCubit = WeatherCubit(weatherRepository);

  runApp(
    BlocProvider(
      create: (context) => weatherCubit,
      child: SplashScreenApp(
        isViewed: isViewed,
      ),
    ),
  );
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

  const App({super.key, required this.isViewed});

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
