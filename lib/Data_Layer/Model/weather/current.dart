import 'condition.dart';

class Current {
  int? lastUpdatedEpoch; // Epoch timestamp of the last update.
  String? lastUpdated; // Last update time as a string.
  double? tempC; // Temperature in degrees Celsius.
  int? tempF; // Temperature in degrees Fahrenheit.
  int? isDay; // Indicator for day or night.
  Condition? condition; // Weather condition details.
  double? windMph; // Wind speed in miles per hour.
  int? windKph; // Wind speed in kilometers per hour.
  int? windDegree; // Wind direction in degrees.
  String? windDir; // Wind direction as a string.
  int? pressureMb; // Atmospheric pressure in millibars.
  double? pressureIn; // Atmospheric pressure in inches of mercury.
  int? precipMm; // Precipitation in millimeters.
  int? precipIn; // Precipitation in inches.
  int? humidity; // Humidity percentage.
  int? cloud; // Cloud cover percentage.
  double? feelslikeC; // "Feels like" temperature in degrees Celsius.
  int? feelslikeF; // "Feels like" temperature in degrees Fahrenheit.
  int? visKm; // Visibility in kilometers.
  int? visMiles; // Visibility in miles.
  int? uv; // UV index.
  double? gustMph; // Wind gust speed in miles per hour.
  double? gustKph; // Wind gust speed in kilometers per hour.

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
  });

  // Factory constructor to create a Current object from a JSON map.
  factory Current.fromJson(Map<String, dynamic> json) => Current(
        lastUpdatedEpoch: json['last_updated_epoch'] as int?,
        lastUpdated: json['last_updated'] as String?,
        tempC: (json['temp_c'] as num?)?.toDouble(),
        tempF: json['temp_f'] as int?,
        isDay: json['is_day'] as int?,
        condition: json['condition'] == null
            ? null
            : Condition.fromJson(json['condition'] as Map<String, dynamic>),
        windMph: (json['wind_mph'] as num?)?.toDouble(),
        windKph: json['wind_kph'] as int?,
        windDegree: json['wind_degree'] as int?,
        windDir: json['wind_dir'] as String?,
        pressureMb: json['pressure_mb'] as int?,
        pressureIn: (json['pressure_in'] as num?)?.toDouble(),
        precipMm: json['precip_mm'] as int?,
        precipIn: json['precip_in'] as int?,
        humidity: json['humidity'] as int?,
        cloud: json['cloud'] as int?,
        feelslikeC: (json['feelslike_c'] as num?)?.toDouble(),
        feelslikeF: json['feelslike_f'] as int?,
        visKm: json['vis_km'] as int?,
        visMiles: json['vis_miles'] as int?,
        uv: json['uv'] as int?,
        gustMph: (json['gust_mph'] as num?)?.toDouble(),
        gustKph: (json['gust_kph'] as num?)?.toDouble(),
      );

  // Convert the Current object to a JSON map.
  Map<String, dynamic> toJson() => {
        'last_updated_epoch': lastUpdatedEpoch,
        'last_updated': lastUpdated,
        'temp_c': tempC,
        'temp_f': tempF,
        'is_day': isDay,
        'condition': condition?.toJson(),
        'wind_mph': windMph,
        'wind_kph': windKph,
        'wind_degree': windDegree,
        'wind_dir': windDir,
        'pressure_mb': pressureMb,
        'pressure_in': pressureIn,
        'precip_mm': precipMm,
        'precip_in': precipIn,
        'humidity': humidity,
        'cloud': cloud,
        'feelslike_c': feelslikeC,
        'feelslike_f': feelslikeF,
        'vis_km': visKm,
        'vis_miles': visMiles,
        'uv': uv,
        'gust_mph': gustMph,
        'gust_kph': gustKph,
      };
}
