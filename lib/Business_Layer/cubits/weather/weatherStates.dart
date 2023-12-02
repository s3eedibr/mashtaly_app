class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherDataState extends WeatherState {
  final String weatherText;
  final String temperature;
  final String icon;
  final String wind;
  final String humidity;
  final String cloud;

  WeatherDataState({
    required this.weatherText,
    required this.temperature,
    required this.icon,
    required this.wind,
    required this.humidity,
    required this.cloud,
  });
}

class NoWeatherDataState extends WeatherState {}

class WeatherErrorState extends WeatherState {
  final String error;

  WeatherErrorState({required this.error});
}
