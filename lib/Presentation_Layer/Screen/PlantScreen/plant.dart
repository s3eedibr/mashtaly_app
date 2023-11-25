import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Constants/colors.dart';
import '../../../Provider/weather_provider.dart';
import '../Forms/form_withOutSen.dart';
import '../Forms/form_withSen.dart';
import '../HomeScreens/notification.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const PlantScreenContent(),
    );
  }
}

class PlantScreenContent extends StatefulWidget {
  const PlantScreenContent({super.key});

  @override
  _PlantScreenContentState createState() => _PlantScreenContentState();
}

class _PlantScreenContentState extends State<PlantScreenContent> {
  DateTime selectedDate = DateTime.now();

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      print(selectedDate);
    });
  }

  @override
  void initState() {
    super.initState();
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider.getLocationAndFetchWeather();
  }

  Future<bool> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 4500));
    return true;
  }

  Future<void> _refreshRandomNumbers() =>
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {});
      });
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: tBgColor,
        body: FutureBuilder<bool>(
          future: _loadData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildLoadingUI();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return buildMainUI(
                newNotification: false,
                icon: weatherProvider.icon,
                weatherText: weatherProvider.weatherText,
                temperature: weatherProvider.temperature,
                cloud: weatherProvider.cloud,
                wind: weatherProvider.wind,
                humidity: weatherProvider.humidity,
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildMainUI({
    required bool newNotification,
    required String icon,
    required String weatherText,
    required String temperature,
    required String cloud,
    required String wind,
    required String humidity,
  }) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: tBgColor,
        body: Column(
          children: [
            Container(
              color: Colors.white,
              height: 56,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                        left: 16,
                        top: 2,
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 375,
                        child: TextField(
                          cursorColor: tPrimaryActionColor,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: tSearchBarColor,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 15,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: tSearchIconColor,
                              size: 27,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Row(
                      children: [
                        IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/icons/Path 417.png",
                            height: 22,
                            width: 22,
                          ),
                        ),
                        IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationScreen(),
                              ),
                            );
                          },
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshRandomNumbers,
                color: tPrimaryActionColor,
                backgroundColor: tBgColor,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
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
                                  : const Icon(
                                      Icons.cloud_off_sharp,
                                      color: Colors.transparent,
                                    ),
                              const SizedBox(
                                width: 5,
                              ),
                              weatherText.isNotEmpty
                                  ? Text(
                                      weatherText,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const Text(
                                      "",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                              if (temperature.isNotEmpty &&
                                  double.parse(temperature) < 30)
                                Image.asset(
                                  'assets/images/icons/Group 237.png',
                                  height: 35,
                                  width: 35,
                                )
                              else if (temperature.isNotEmpty &&
                                  double.parse(temperature) >= 30)
                                Image.asset(
                                  'assets/images/icons/Group 226.png',
                                  height: 35,
                                  width: 35,
                                )
                              else
                                const Icon(
                                  Icons.cloud_off_rounded,
                                  color: Colors.transparent,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              temperature.isNotEmpty
                                  ? Text(
                                      '$temperature°C',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const Text(
                                      '',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ],
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
                        padding: const EdgeInsets.only(
                            right: 16, bottom: 0, left: 16),
                        child: SizedBox(
                          height: 80,
                          child: DatePicker(
                            DateTime.now(),
                            width: 45,
                            initialSelectedDate: selectedDate,
                            selectionColor: tPrimaryActionColor,
                            selectedTextColor: Colors.white,
                            dateTextStyle: const TextStyle(
                              fontSize: 20,
                            ),
                            daysCount: 14,
                            onDateChange: onDateSelected,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                      color: Colors.white,
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
                        padding: const EdgeInsets.only(
                            right: 16, bottom: 0, left: 17),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        cloud.isNotEmpty
                                            ? Text(
                                                '$cloud%',
                                                style: const TextStyle(
                                                    color: tPrimaryTextColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            : const Text(
                                                '',
                                                style: TextStyle(
                                                    color: tPrimaryTextColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        wind.isNotEmpty
                                            ? Text(
                                                '$wind Km/h',
                                                style: const TextStyle(
                                                    color: tPrimaryTextColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            : const Text(
                                                '',
                                                style: TextStyle(
                                                    color: tPrimaryTextColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Humidity",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: tPrimaryPlusTextColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        humidity.isNotEmpty
                                            ? Text(
                                                '$humidity%',
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    color: tPrimaryTextColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            : const Text(
                                                '',
                                                style: TextStyle(
                                                    color: tPrimaryTextColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                    const SizedBox(
                      height: 19,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16, bottom: 0, left: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Schedule",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 225,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, bottom: 0, left: 17),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 130,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  color: tPrimaryActionColor,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.16),
                                                      spreadRadius: 1,
                                                      blurRadius: 7,
                                                      offset: const Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AddPlantFormWithSen(),
                                                      ),
                                                    );
                                                  },
                                                  highlightColor: Colors.white
                                                      .withOpacity(0.05),
                                                  icon: Image.asset(
                                                    'assets/images/icons/smart-farm.png',
                                                    height: 65,
                                                    width: 65,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const Text(
                                                'With Sensor',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 18,
                                              ),
                                              Container(
                                                height: 130,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  color: tPrimaryActionColor,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.16),
                                                      spreadRadius: 1,
                                                      blurRadius: 7,
                                                      offset: const Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AddPlantFormWithOutSen(),
                                                      ),
                                                    );
                                                  },
                                                  highlightColor: Colors.white
                                                      .withOpacity(0.05),
                                                  icon: Image.asset(
                                                    'assets/images/icons/Untitled-3@3x.png',
                                                    height: 65,
                                                    width: 65,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const Text(
                                                'Without Sensor',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Text(
                                                'Mashtaly Data',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: tPrimaryActionColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Add Plant",
                                  style: TextStyle(
                                      color: tPrimaryActionColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16, bottom: 0, left: 17),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Positioned(
                            bottom: 88.5,
                            top: 15,
                            right: 125,
                            left: 125,
                            child: Image.asset(
                              'assets/images/stack_images/Group 2.png',
                              height: 102,
                              width: 88,
                            ),
                          ),
                          Positioned(
                            bottom: 153,
                            right: 27,
                            left: 235,
                            child: Image.asset(
                              'assets/images/stack_images/Group 390.png',
                              height: 110,
                              width: 80,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 180,
                              bottom: 13,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              "You don't have any plants yet\nAdd your plant now",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Other methods and variables...

Widget buildLoadingUI() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/plant_loading2.gif",
          height: 100,
          width: 100,
        ),
        const SizedBox(height: 16),
        const Text(
          'Loading...',
          style: TextStyle(
            color: tPrimaryTextColor,
            fontFamily: 'Mulish',
            decoration: TextDecoration.none,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
