import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Business_Layer/cubits/add_plant/add_plant_Cubit.dart';
import 'package:mashtaly_app/Business_Layer/cubits/add_plant/add_plant_States.dart';
// import 'package:mashtaly_app/Presentation_Layer/Screen/Plant/Widget/plant_card.dart';

import '../../../Business_Layer/cubits/weather/weatherCubit.dart';
import '../../../Business_Layer/cubits/weather/weatherStates.dart';
import '../../../Constants/colors.dart';
// import '../../../sql.dart';
import '../HomeScreens/notification.dart';
import 'Widget/buildLoadingUI.dart';
import 'Widget/choiceButtons.dart';
import 'Widget/noPlantData.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  DateTime selectedDate = DateTime.now();

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      print(selectedDate);
    });
  }

  Future<bool> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 4500));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final weatherCubit = BlocProvider.of<WeatherCubit>(context);
    weatherCubit.getLocationAndFetchWeather();
    const bool newNotification = true;
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0, // No shadow
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                width: 385,
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
            Padding(
              padding: const EdgeInsets.only(right: 1),
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
                          builder: (context) => const NotificationScreen(),
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
      body: FutureBuilder<bool>(
        future: _loadData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading UI while waiting for the future to complete.
            return buildLoadingUI();
          } else if (snapshot.hasError) {
            // Display an error message if there is an error in the future.
            return Text('Error: ${snapshot.error}');
          } else {
            // Use BlocBuilder to handle state changes from the WeatherCubit.
            return BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadingState) {
                  // Display a loading UI while waiting for weather data.
                  return buildLoadingUI();
                } else if (state is WeatherDataState) {
                  // Display the main UI with weather data when available.
                  return buildMainUI(
                    icon: state.icon,
                    weatherText: state.weatherText,
                    temperature: state.temperature,
                    cloud: state.cloud,
                    wind: state.wind,
                    humidity: state.humidity,
                  );
                } else if (state is WeatherErrorState) {
                  // Display an error message if there is an error in the WeatherCubit.
                  return Text(state.error);
                }
                // If none of the above conditions are met, return an empty Container.
                return Container();
              },
            );
          }
        },
      ),
    );
  }

  Widget buildMainUI({
    required String icon,
    required String weatherText,
    required String temperature,
    required String cloud,
    required String wind,
    required String humidity,
  }) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() {});
        },
        color: tPrimaryActionColor,
        backgroundColor: tBgColor,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 0, left: 15),
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
                      weatherText.isNotEmpty && weatherText.length < 20
                          ? Text(
                              weatherText,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(
                              weatherText,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                padding: const EdgeInsets.only(right: 16, bottom: 0, left: 16),
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
                padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            fontWeight: FontWeight.w700),
                                      )
                                    : const Text(
                                        '',
                                        style: TextStyle(
                                            color: tPrimaryTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            fontWeight: FontWeight.w700),
                                      )
                                    : const Text(
                                        '',
                                        style: TextStyle(
                                            color: tPrimaryTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            fontWeight: FontWeight.w700),
                                      )
                                    : const Text(
                                        '',
                                        style: TextStyle(
                                            color: tPrimaryTextColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
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
              padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
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
                      showChoiceButtonsAddPlant(context);
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
              padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
              child: BlocBuilder<PlantCubit, PlantState>(
                builder: (context, state) {
                  // List<Map<String, dynamic>>? myPlants;
                  if (state is PlantNoDataState) {
                    return const NoPlantData();
                  }
                  if (state is PlantLoadDataState) {
                    // return SizedBox(
                    //   height: 250,
                    //   child: FutureBuilder(
                    //     future: checkConnectivity(),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.data == ConnectivityResult.none) {
                    //         showSnackBar(context, 'No internet connection.');
                    //       }

                    //       return FutureBuilder<List<Map<String, dynamic>>>(
                    //         future: getMyPlants(
                    //           FirebaseAuth.instance.currentUser!.uid,
                    //         ),
                    //         builder: (context, snapshot) {
                    //           if (snapshot.connectionState ==
                    //               ConnectionState.waiting) {
                    //             return ListView(
                    //               scrollDirection: Axis.horizontal,
                    //               children: [
                    //                 PlantCard.buildShimmerCard(),
                    //                 PlantCard.buildShimmerCard(),
                    //               ],
                    //             );
                    //           }

                    //           myPlants = snapshot.data;

                    //           if (myPlants == null) {
                    //             return const Center(
                    //               child: Text('No Plants available.'),
                    //             );
                    //           }
                    //           if (snapshot.hasError) {
                    //             return Center(
                    //               child: Text('Error: ${snapshot.error}'),
                    //             );
                    //           }

                    //           return Container();
                    //         },
                    //       );
                    //     },
                    //   ),
                    // );
                  } else if (state is PlantSuccessDataState) {
                    // return SizedBox(
                    //   height: 250,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: myPlants.length > 2 ? 2 : myPlants.length,
                    //     itemBuilder: (BuildContext context, index) {
                    //       if (index < myPlants!.length) {
                    //         final myplants = myPlants![index];
                    //         return GestureDetector(
                    //           onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SaleDetails(
                    //       profileImage: myplants['profile_pic'],
                    //       user: myplants['user'],
                    //       imageURL1: myplants['sale_pic1'],
                    //       imageURL2: myplants['sale_pic2'],
                    //       imageURL3: myplants['sale_pic3'],
                    //       imageURL4: myplants['sale_pic4'],
                    //       imageURL5: myplants['sale_pic5'],
                    //       title: myplants['title'],
                    //       date: myplants['date'],
                    //       content: myplants['content'],
                    //       phoneNumber: myplants['phone_number'],
                    //     ),
                    //   ),
                    // );
                    //           },
                    //           child: PlantCard(
                    //             imageFile: myplants['myPlant_pic1'],
                    //             plantName: myplants['plantName'],
                    //           ),
                    //         );
                    //       }
                    //       return const SizedBox.shrink();
                    //     },
                    //   ),
                    // );
                  } else if (state is PlantErrorState) {
                    // return const Text("There is an error");
                  }
                  return Container();
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
