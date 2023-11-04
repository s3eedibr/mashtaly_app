class Location {
  String? name; // Name of the location.
  String? region; // Region information.
  String? country; // Country information.
  double? lat; // Latitude.
  double? lon; // Longitude.
  String? tzId; // Timezone identifier.
  int? localtimeEpoch; // Local time in epoch format.
  String? localtime; // Local time as a string.

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  // Factory constructor to create a Location object from a JSON map.
  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'] as String?,
        region: json['region'] as String?,
        country: json['country'] as String?,
        lat: (json['lat'] as num?)?.toDouble(),
        lon: (json['lon'] as num?)?.toDouble(),
        tzId: json['tz_id'] as String?,
        localtimeEpoch: json['localtime_epoch'] as int?,
        localtime: json['localtime'] as String?,
      );

  // Convert the Location object to a JSON map.
  Map<String, dynamic> toJson() => {
        'name': name,
        'region': region,
        'country': country,
        'lat': lat,
        'lon': lon,
        'tz_id': tzId,
        'localtime_epoch': localtimeEpoch,
        'localtime': localtime,
      };
}
