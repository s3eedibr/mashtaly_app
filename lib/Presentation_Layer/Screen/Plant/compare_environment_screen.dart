import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Business_Layer/cubits/show_weather/weatherCubit.dart';
import '../../../Constants/assets.dart';
import '../../../Constants/colors.dart';

class CompareEnvironmentScreen extends StatefulWidget {
  final String? plantName;
  const CompareEnvironmentScreen({super.key, this.plantName});

  @override
  State<CompareEnvironmentScreen> createState() =>
      _CompareEnvironmentScreenState();
}

class _CompareEnvironmentScreenState extends State<CompareEnvironmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.close,
              size: 28,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: const Text(
          'Compare Environment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: tPrimaryTextColor, // Adjust text color
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Your Environment for ',
                    style: const TextStyle(
                      fontSize: 18,
                      color: tPrimaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${widget.plantName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' is',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: tWateringColor,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: const Center(
                    child: Text(
                      'State',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 130,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.assetsImagesIconsPath465,
                              height: 35,
                              width: 35,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Temperature',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: tPrimaryPlusTextColor),
                            ),
                          ],
                        ),
                        Container(
                          height: 35,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: tDelayedColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'state',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Best',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryPlusTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '16-24 °C',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: tSearchIconColor,
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Yours',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryPlusTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${BlocProvider.of<WeatherCubit>(context).temperature}°C',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 130,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.assetsImagesIconsPath466,
                              height: 35,
                              width: 35,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Cloud',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: tPrimaryPlusTextColor),
                            ),
                          ],
                        ),
                        Container(
                          height: 35,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: tDelayedColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'state',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Best',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryPlusTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '16-24 °C',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: tSearchIconColor,
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Yours',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryPlusTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${BlocProvider.of<WeatherCubit>(context).cloud}%',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 130,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.assetsImagesIconsPath416,
                              height: 35,
                              width: 35,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Humidity',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: tPrimaryPlusTextColor),
                            ),
                          ],
                        ),
                        Container(
                          height: 35,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: tDelayedColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'state',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Best',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryPlusTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '16-24 °C',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: tSearchIconColor,
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Yours',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryPlusTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${BlocProvider.of<WeatherCubit>(context).humidity}%',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 130,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.assetsImagesIconsPath467,
                              height: 35,
                              width: 35,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Wind',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: tPrimaryPlusTextColor),
                            ),
                          ],
                        ),
                        Container(
                          height: 35,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: tDelayedColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'state',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Best',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryPlusTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '16-24 °C',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: tSearchIconColor,
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Yours',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryPlusTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${BlocProvider.of<WeatherCubit>(context).wind} Km/h',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: tPrimaryTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
