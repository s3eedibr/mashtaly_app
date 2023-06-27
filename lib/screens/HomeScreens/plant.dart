import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mashtaly_app/Animations/waiting_screen.dart';
import 'package:mashtaly_app/Services/weather_service.dart';

import '../../Constants/colors.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  Future<bool> _loadData() async {
    // Simulating an asynchronous task, e.g., loading data
    await Future.delayed(const Duration(milliseconds: 2500));
    return true;
  }

  WeatherService weather = WeatherService();
  double? latitude;
  double? longitude;
  String weatherText = '';
  String temperature = '';
  String icon = '';
  String wind = '';
  String humidity = '';
  String cloud = '';
  LocationPermission? permission;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void getLocation() async {
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    startTimer();
  }

  void getWeatherData() async {
    if (latitude != null && longitude != null) {
      print(
          "********************************Get Location********************************");
      Map<String, dynamic>? weatherData = await weather.getWeather(
        latitude: latitude!,
        longitude: longitude!,
      );
      if (weatherData != null) {
        setState(() {
          print(
              "********************************Get WeatherData********************************");
          weatherText = weatherData['current']['condition']['text'];
          temperature = weatherData['current']['temp_c'].toString();
          String iconPath = weatherData['current']['condition']['icon'];
          icon = 'http:$iconPath';
          wind = weatherData['current']['wind_kph'].toString();
          humidity = weatherData['current']['humidity'].toString();
          cloud = weatherData['current']['cloud'].toString();
        });
      }
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(minutes: 30), (Timer t) {
      getWeatherData();
    });
    getWeatherData(); // Fetch data immediately when the app starts
  }

  bool newNotification = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      body: FutureBuilder<bool>(
        future: _loadData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print(
                "********************************Waiting Screen********************************");
            return WaitingScreen();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Render your regular UI once the data is loaded
            return Scaffold(
              backgroundColor: tBgColor,
              body: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 69,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8, bottom: 0, left: 16),
                            child: TextField(
                              cursorColor: tPrimaryActionColor,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: tSearchBarColor,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: tSearchIconColor,
                                  size: 27,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  "assets/images/icons/Path 417.png",
                                  height: 22,
                                  width: 22,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: newNotification == false
                                    ? Image.asset(
                                        "assets/images/icons/Path 2.png",
                                        height: 22,
                                        width: 22,
                                      )
                                    : Image.asset(
                                        "assets/images/icons/Path 2red.png",
                                        height: 22,
                                        width: 22,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, bottom: 0, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            icon.isNotEmpty
                                ? Image.network(
                                    icon,
                                    height: 38,
                                    width: 38,
                                  )
                                : Icon(Icons.cloud_off_sharp),
                            SizedBox(
                              width: 5,
                            ),
                            weatherText.isNotEmpty
                                ? Text(
                                    weatherText,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "Weatherapi",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ],
                        ),
                        Text(
                          '$temperature°c',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 16, bottom: 0, left: 16),
                      child: SizedBox(
                        height: 80,
                        child: DatePicker(
                          DateTime.now(),
                          width: 45,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: tPrimaryActionColor,
                          selectedTextColor: Colors.white,
                          dateTextStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          daysCount: 14,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 16, bottom: 0, left: 17),
                      child: SizedBox(
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/icons/Group 204.png',
                                  height: 45,
                                  width: 45,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Cloud",
                                        style: TextStyle(
                                            color: tPrimaryPlusTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '$cloud%',
                                        style: TextStyle(
                                            color: tPrimaryTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/icons/Group 203.png',
                                  height: 45,
                                  width: 45,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Wind",
                                        style: TextStyle(
                                            color: tPrimaryPlusTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '$wind Km/h',
                                        style: TextStyle(
                                            color: tPrimaryTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/icons/Group 199.png',
                                  height: 45,
                                  width: 45,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Humidity",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: tPrimaryPlusTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '$humidity%',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: tPrimaryTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
