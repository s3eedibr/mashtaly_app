import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mashtaly_app/Services/wikipedia_service.dart';

import '../../../Constants/colors.dart';

class MyPlantsInfoScreen extends StatefulWidget {
  final String? plantName;
  final String? imageUrl;
  final bool? active;

  const MyPlantsInfoScreen({
    Key? key,
    required this.plantName,
    this.imageUrl,
    this.active,
  }) : super(key: key);

  @override
  State<MyPlantsInfoScreen> createState() => _MyPlantsInfoScreenState();
}

class _MyPlantsInfoScreenState extends State<MyPlantsInfoScreen> {
  String para = '';
  bool switchValue = false;

  @override
  void initState() {
    super.initState();
    fetchPlantInformation(widget.plantName!, '').then((value) {
      setState(() {
        para = value;
      });
    }).catchError((error) {
      print('Error fetching plant information: $error');
    });
  }

  bool _isValidUrl(String url) {
    return url.isNotEmpty &&
        (url.startsWith("http://") || url.startsWith("https://"));
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
            fontSize: 20,
            fontWeight: FontWeight.w500,
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
              onChanged: (newValue) {
                setState(() {
                  switchValue = newValue;
                  print(switchValue);
                });
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
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl!,
                    height: 250,
                    width: width,
                    fit: BoxFit.fitWidth,
                    placeholder: (BuildContext context, String url) =>
                        const Center(
                            child: CircularProgressIndicator(
                      color: tPrimaryActionColor,
                    )),
                    errorWidget:
                        (BuildContext context, String url, dynamic error) =>
                            const Center(
                      child: Icon(Icons.not_interested_rounded),
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
                          switchValue == false
                              ? const Text(
                                  "Recommendation",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const Text(
                                  "Daily Schedule",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          switchValue == false
                              ? MaterialButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Compare",
                                    style: TextStyle(
                                        color: tPrimaryActionColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : MaterialButton(
                                  onPressed: () {},
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
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Water",
                                  style: TextStyle(
                                      color: tPrimaryPlusTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '200ml',
                                  style: TextStyle(
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
                                const Text(
                                  '16°C',
                                  style: TextStyle(
                                      color: tPrimaryTextColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 95,
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
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
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
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
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
                                        'Km/h',
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
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
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
                                        '%',
                                        textAlign: TextAlign.left,
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
                onPressed: () {
                  setState(() {
                    switchValue = true;
                  });
                },
                child: const Center(
                    child: Text(
                  "Add to My Plants",
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
                onPressed: () {},
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
