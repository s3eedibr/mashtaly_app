class Location {
  double? lat; // Latitude.
  double? lon; // Longitude.

  Location({
    this.lat,
    this.lon,
  });

  // Factory constructor to create a Location object from a JSON map.
  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: (json['lat'] as num?)?.toDouble(),
        lon: (json['lon'] as num?)?.toDouble(),
      );

  // Convert the Location object to a JSON map.
  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
