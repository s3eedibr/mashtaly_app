class WateringTime {
  String time;
  List<String> plants;

  WateringTime({required this.time, required this.plants});

  @override
  String toString() {
    return 'WateringTime{time: $time, plants: $plants}';
  }
}
