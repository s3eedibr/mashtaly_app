import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../Data_Layer/Model/weather/weather.dart';
import '../../Data_Layer/Repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit(this.weatherRepository) : super(WeatherInitial());

  Future<List<Weather>> fetchWeatherData() async {
    try {
      // Retrieve the device's current location (latitude and longitude).
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Extract latitude and longitude from the position.
      double latitude = position.latitude;
      double longitude = position.longitude;

      // Use the obtained latitude and longitude to fetch weather data.
      final weather = await weatherRepository.fetchWeatherData(
          latitude: latitude, longitude: longitude);

      // Emit the WeatherLoaded state with the fetched weather data.
      return weather as List<Weather>;
    } catch (e) {
      // Emit the WeatherError state with an error message in case of an error.
      emit(WeatherError('Failed to fetch weather data: $e'));

      // If an error occurs, return an empty list or handle the error as needed.
      return <Weather>[];
    }
  }
}
