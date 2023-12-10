import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Animations/no_connection_screen.dart';
import 'Animations/splash_screen.dart';
import 'Auth/auth.dart';
import 'Business_Layer/cubits/add_plant/add_plant_Cubit.dart';
import 'Business_Layer/cubits/show_plant/cubit/show_plant_data_cubit.dart';
import 'Business_Layer/cubits/show_weather/weatherCubit.dart';
import 'Constants/colors.dart';
import 'Presentation_Layer/Screen/OnboradingScreen/onboarding_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const SplashScreenApp());
}

class SplashScreenApp extends StatelessWidget {
  const SplashScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        onSplashFinished: () async {
          // Check for internet connectivity after the splash screen finishes
          var connectivityResult = await Connectivity().checkConnectivity();
          bool hasInternet = connectivityResult != ConnectivityResult.none;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          int? isViewed = prefs.getInt('onBoard');

          runApp(MyApp(
            isViewed: isViewed,
            hasInternet: hasInternet,
          ));
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final int? isViewed;
  final bool hasInternet;

  const MyApp({Key? key, this.isViewed, required this.hasInternet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: hasInternet
          ? MashtalyApp(
              isViewed: isViewed,
            )
          : const NoConnectionScreen(),
    );
  }
}

class MashtalyApp extends StatelessWidget {
  final int? isViewed;

  const MashtalyApp({Key? key, required this.isViewed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(),
        ),
        BlocProvider<AddPlantCubit>(
          create: (context) => AddPlantCubit(),
        ),
        BlocProvider<ShowPlantCubit>(
          create: (context) => ShowPlantCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Mulish',
            useMaterial3: true,
            dialogBackgroundColor: Colors.white,
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.white,
            ),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: tPrimaryActionColor.withOpacity(.5),
              cursorColor: tPrimaryActionColor.withOpacity(.6),
              selectionHandleColor: tPrimaryActionColor.withOpacity(1),
            ),
          ),
          home: isViewed != 0 ? const OnBoardingScreen() : const Auth(),
        );
      }),
    );
  }
}
