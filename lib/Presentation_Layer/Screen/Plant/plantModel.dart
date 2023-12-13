class PlantModel {
  // bool active;
  // String amountOfWater;
  // String date;
  // String from;
  // String id;
  String myPlantPic1;
  String plantName;
  // List<Map<String, dynamic>> schedule;
  // bool sensor;
  // String until;
  // String userId;
  // List<Map<String, dynamic>> weatherConditionsAndDurations;

  PlantModel({
    // required this.active,
    // required this.amountOfWater,
    // required this.date,
    // required this.from,
    // required this.id,
    required this.myPlantPic1,
    required this.plantName,
    //   required this.schedule,
    //   required this.sensor,
    //   required this.until,
    //   required this.userId,
    //   required this.weatherConditionsAndDurations,
  });

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      // active: json['active'] ?? false,
      // amountOfWater: json['amountOfWater'] ?? '',
      // date: json['date'] ?? '',
      // from: json['from'] ?? '',
      // id: json['id'] ?? '',
      myPlantPic1: json['myPlant_pic1'],
      plantName: json['plantName'],
      // schedule: List<Map<String, dynamic>>.from(json['schedule'] ?? []),
      // sensor: json['sensor'] ?? false,
      // until: json['until'] ?? '',
      // userId: json['user_id'] ?? '',
      // weatherConditionsAndDurations: List<Map<String, dynamic>>.from(
      //     json['weatherConditionsAndDurations'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'active': active,
      // 'amountOfWater': amountOfWater,
      // 'date': date,
      // 'from': from,
      // 'id': id,
      'myPlant_pic1': myPlantPic1,
      'plantName': plantName,
      // 'schedule': schedule,
      // 'sensor': sensor,
      // 'until': until,
      // 'user_id': userId,
      // 'weatherConditionsAndDurations': weatherConditionsAndDurations,
    };
  }
}
