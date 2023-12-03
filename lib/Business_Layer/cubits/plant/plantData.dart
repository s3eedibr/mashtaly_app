class PlantData {
  final int id;
  final String imagePath;
  final String plantName;
  final double amountOfWater;
  final String type;
  final int active;
  final String fromDate;
  final String untilDate;

  PlantData({
    required this.id,
    required this.imagePath,
    required this.plantName,
    required this.amountOfWater,
    required this.type,
    required this.active,
    required this.fromDate,
    required this.untilDate,
  });

  factory PlantData.fromMap(Map<String, dynamic> map) {
    return PlantData(
      id: map['id'],
      imagePath: map['imagePath'],
      plantName: map['plantName'],
      amountOfWater: map['amountOfWater'],
      type: map['type'],
      active: map['active'],
      fromDate: map['fromDate'],
      untilDate: map['untilDate'],
    );
  }
}
