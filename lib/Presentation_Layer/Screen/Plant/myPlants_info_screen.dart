// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Plant/Forms/edit_plant_with_Sensor.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Plant/Forms/edit_plant_without_Sensor.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Plant/compare_environment_screen.dart';

import 'package:mashtaly_app/Services/wikipedia_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Business_Layer/cubits/add_plant/add_plant_Cubit.dart';
import '../../../Business_Layer/cubits/show_weather/weatherCubit.dart';
import '../../../Constants/colors.dart';
import 'Data/getData.dart';
import 'Widget/delayed_Watering_Column.dart';
import 'Widget/weather_Condition_Column.dart';

class MyPlantsInfoScreen extends StatefulWidget {
  final String? plantName;
  final String? imageUrl;
  final bool? active;
  final bool? sensor;
  final String? amountOfWater;
  final String? id;
  final String? from;
  final String? until;

  const MyPlantsInfoScreen({
    Key? key,
    required this.plantName,
    required this.imageUrl,
    required this.active,
    required this.sensor,
    required this.id,
    this.amountOfWater,
    this.from,
    this.until,
  }) : super(key: key);

  @override
  State<MyPlantsInfoScreen> createState() => _MyPlantsInfoScreenState();
}

class _MyPlantsInfoScreenState extends State<MyPlantsInfoScreen> {
  String para = '';
  late bool switchValue;
  late String? amountOfWater;
  @override
  void initState() {
    super.initState();
    switchValue = widget.active!;
    amountOfWater = widget.amountOfWater!;
    fetchPlantInformation(widget.plantName!, '').then((value) {
      setState(() {
        para = value;
      });
    }).catchError((error) {
      print('Error fetching plant information: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final myPlantCubit = BlocProvider.of<AddPlantCubit>(context);
    final width = MediaQuery.of(context).size.width;
    List<List<dynamic>> allWeatherData = [];
    List<List<dynamic>>? allScheduleData = [];
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: const Text(
          "Plant Information",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: tPrimaryTextColor, // Adjust text color
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Switch(
              value: switchValue,
              onChanged: (newValue) async {
                setState(
                  () {
                    switchValue = newValue;
                  },
                );
                await updateActiveFlagForMyPlant(
                    collectionName: 'myPlants',
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    myId: widget.id!,
                    isActive: switchValue);
                myPlantCubit.updateData(FirebaseAuth.instance.currentUser!.uid);

                print(widget.id!);
                print(switchValue);
              },
              activeTrackColor: const Color(0xff9BEC79),
              activeColor: const Color(0xff66B821),
              inactiveTrackColor: const Color(0xFFFF3324),
              inactiveThumbColor: tBgColor,
              trackOutlineColor:
                  const MaterialStatePropertyAll<Color?>(Colors.transparent),
            ),
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: widget.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: widget.imageUrl!,
                          height: 250,
                          width: width,
                          fit: BoxFit.fitWidth,
                          placeholder: (BuildContext context, String url) =>
                              const Center(
                            child: CircularProgressIndicator(
                              color: tPrimaryActionColor,
                            ),
                          ),
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              const Center(
                            child: Icon(Icons.not_interested_rounded),
                          ),
                        )
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 250,
                            width: width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.plantName ?? "",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.ellipsisVertical,
                              color: tSecondTextColor,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        para,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          height: 1.8,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Daily Schedule",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              print('$allWeatherData =- my plant info screen');
                              widget.sensor == true
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EditPlantFormWithSen(
                                            plantName: widget.plantName!,
                                            imageURL: widget.imageUrl!,
                                            id: widget.id!,
                                            active: widget.active!,
                                            amountOfWater: amountOfWater,
                                            from: widget.from,
                                            until: widget.until,
                                          );
                                        },
                                      ),
                                    )
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EditPlantFormWithOutSen(
                                            plantName: widget.plantName!,
                                            imageURL: widget.imageUrl!,
                                            id: widget.id!,
                                            active: widget.active!,
                                            amountOfWater: amountOfWater,
                                            from: widget.from,
                                            until: widget.until,
                                            delayedDuration: allWeatherData,
                                            delaySchedule: allScheduleData,
                                          );
                                        },
                                      ),
                                    );
                              print(allScheduleData);
                            },
                            child: const Text(
                              "Edit",
                              style: TextStyle(
                                  color: tPrimaryActionColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/icons/Group 195.png',
                                height: 45,
                                width: 45,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Watering in    ",
                                      style: TextStyle(
                                          color: tPrimaryPlusTextColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Hour',
                                      style: TextStyle(
                                          color: tPrimaryTextColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/icons/Line 7.png',
                            height: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "  Water",
                                  style: TextStyle(
                                      color: tPrimaryPlusTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '  ${amountOfWater ?? ''} ml',
                                  style: const TextStyle(
                                      color: tPrimaryTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Delayed watering',
                            style: TextStyle(
                              fontSize: 15,
                              color: tPrimaryPlusTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            'If',
                            style: TextStyle(
                              fontSize: 15,
                              color: tPrimaryPlusTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: FutureBuilder<List<List<dynamic>>>(
                          future: fetchWeatherConditionAndDuration(
                              myId: widget.id!,
                              userId: FirebaseAuth.instance.currentUser!.uid),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<List<dynamic>>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildShimmerDelayedWatering(),
                                  buildShimmerWeatherCondition(),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text(
                                'No delayed data available',
                                style: TextStyle(
                                  height: 3,
                                  color: tPrimaryPlusTextColor,
                                ),
                              );
                            } else {
                              return SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List<dynamic> weatherData =
                                        snapshot.data![index];

                                    if (weatherData.isNotEmpty) {
                                      allWeatherData.add(weatherData);
                                    }

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        DelayedWateringColumn(
                                          days: weatherData[1],
                                          hours: weatherData[2],
                                          minutes: weatherData[3],
                                        ),
                                        WeatherConditionColumn(
                                          selectedWeatherText: weatherData[0],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 1,
                        child: FutureBuilder<List<List<dynamic>>>(
                          future: fetchTimeInEachWeekAndDay(
                              myId: widget.id!,
                              userId: FirebaseAuth.instance.currentUser!.uid),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<List<dynamic>>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text(
                                'No delayed data available',
                                style: TextStyle(
                                  height: 3,
                                  color: tPrimaryPlusTextColor,
                                ),
                              );
                            } else {
                              return SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List<dynamic> scheduleData =
                                        snapshot.data![index];

                                    if (scheduleData.isNotEmpty) {
                                      allScheduleData.add(scheduleData);
                                    }

                                    return Container();
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          switchValue == true
                              ? const Text(
                                  "Recommended",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const Text(
                                  "Recommendation",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CompareEnvironmentScreen(
                                      plantName: widget.plantName,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              "Compare",
                              style: TextStyle(
                                  color: tPrimaryActionColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/icons/Group 195.png',
                                height: 45,
                                width: 45,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Watering every",
                                      style: TextStyle(
                                          color: tPrimaryPlusTextColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Hour',
                                      style: TextStyle(
                                          color: tPrimaryTextColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/icons/Line 7.png',
                            height: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Water",
                                  style: TextStyle(
                                      color: tPrimaryPlusTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${amountOfWater ?? ''} ml',
                                  style: const TextStyle(
                                      color: tPrimaryTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/icons/Group 237.png',
                                  height: 45,
                                  width: 45,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${double.parse(BlocProvider.of<WeatherCubit>(context).temperature!)}°C',
                                  style: const TextStyle(
                                      color: tPrimaryTextColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 85,
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
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${BlocProvider.of<WeatherCubit>(context).cloud}%',
                                        style: const TextStyle(
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
                                      Text(
                                        '${BlocProvider.of<WeatherCubit>(context).wind} Km/h',
                                        style: const TextStyle(
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
                                      Text(
                                        '${BlocProvider.of<WeatherCubit>(context).humidity}%',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 55,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 380,
        child: switchValue == false
            ? FloatingActionButton(
                backgroundColor: tPrimaryActionColor,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    switchValue = true;
                  });
                  await updateActiveFlagForMyPlant(
                      collectionName: 'myPlants',
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      myId: widget.id!,
                      isActive: switchValue);
                  myPlantCubit
                      .updateData(FirebaseAuth.instance.currentUser!.uid);

                  print(widget.id!);
                },
                child: const Center(
                    child: Text(
                  "Add to my plants",
                  style: TextStyle(
                    color: tThirdTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
              )
            : FloatingActionButton(
                backgroundColor: tThirdTextErrorColor,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  print('$allWeatherData =- my plant info screen second one');

                  widget.sensor == true
                      ? Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return EditPlantFormWithSen(
                                plantName: widget.plantName!,
                                imageURL: widget.imageUrl!,
                                id: widget.id!,
                                active: widget.active!,
                                amountOfWater: amountOfWater,
                                from: widget.from,
                                until: widget.until,
                                delayedDuration: allWeatherData,
                              );
                            },
                          ),
                        )
                      : Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return EditPlantFormWithOutSen(
                                plantName: widget.plantName!,
                                imageURL: widget.imageUrl!,
                                id: widget.id!,
                                active: widget.active!,
                                amountOfWater: amountOfWater,
                                from: widget.from,
                                until: widget.until,
                                delayedDuration: allWeatherData,
                                delaySchedule: allScheduleData,
                              );
                            },
                          ),
                        );
                },
                child: const Center(
                  child: Text(
                    "Edit My Plant",
                    style: TextStyle(
                      color: tThirdTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
