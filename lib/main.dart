import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Animations/splash_screen.dart';
import 'Auth/auth.dart';
import 'Constants/colors.dart';
import 'Presentation_Layer/Screen/OnboradingScreen/onboarding_screen.dart';
import 'app_router.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? isViewed =
      prefs.getInt('onBoard'); // Check if onboarding has been viewed.

  // Run the app by displaying the splash screen.
  runApp(SplashScreenApp(
    isViewed: isViewed,
    appRouter: AppRouter(),
  ));
}

class SplashScreenApp extends StatelessWidget {
  final int? isViewed;
  final AppRouter appRouter;

  const SplashScreenApp(
      {super.key, required this.isViewed, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        onSplashFinished: () {
          runApp(App(
            isViewed: isViewed,
            appRouter: appRouter,
          ));
        },
      ),
    );
  }
}

class App extends StatelessWidget {
  final int? isViewed;
  final AppRouter appRouter;

  const App({super.key, required this.isViewed, required this.appRouter});

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
      onGenerateRoute: appRouter.generateRoute,

      // Show OnBoardingScreen if it hasn't been viewed, otherwise show Auth
      home: isViewed != 0 ? const OnBoardingScreen() : const Auth(),
    );
  }
}
