import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Business_Layer/cubit/weather_cubit.dart';
import 'Constants/text_strings.dart';
import 'Data_Layer/Repository/weather_repository.dart';
import 'Presentation_Layer/Screen/HomeScreens/home_screen.dart';

class AppRouter {
  late WeatherRepository weatherRepository;
  late WeatherCubit weatherCubit;

  AppRouter() {
    // Initialize your weather repository with your setup or configurations.
    weatherRepository = WeatherRepository();

    // Initialize the weather Cubit using the repository.
    weatherCubit = WeatherCubit(weatherRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            // Use the weatherCubit initialized in the constructor.
            create: (BuildContext context) => weatherCubit,
            child: const HomeScreen(),
          ),
        );
    }
    return null;
  }
}
