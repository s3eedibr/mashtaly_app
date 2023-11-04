import 'current.dart';
import 'location.dart';

class Weather {
  Location? location; // Represents location data in the Weather object.
  Current? current; // Represents current weather data in the Weather object.

  Weather({this.location, this.current});

  // Factory constructor to create a Weather object from a JSON map.
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        current: json['current'] == null
            ? null
            : Current.fromJson(json['current'] as Map<String, dynamic>),
      );

  // Convert the Weather object to a JSON map.
  Map<String, dynamic> toJson() => {
        'location': location?.toJson(), // Convert Location to JSON.
        'current': current?.toJson(), // Convert Current to JSON.
      };
}
