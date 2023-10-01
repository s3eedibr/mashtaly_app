// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Screens/HomeScreens/camera_scanner_screen.dart';
import 'package:mashtaly_app/Services/wikipedia_service.dart';
import 'package:http/http.dart' as http;

import '../../Constants/colors.dart';

class PlantsInfoScreen extends StatefulWidget {
  final String? plantName;
  final String? commonName;
  const PlantsInfoScreen({
    Key? key,
    required this.plantName,
    this.commonName,
  }) : super(key: key);

  @override
  State<PlantsInfoScreen> createState() => _PlantsInfoScreenState();
}

class _PlantsInfoScreenState extends State<PlantsInfoScreen> {
  String para = '';
  List<String> photoUrls = []; // Move the list declaration here

  @override
  void initState() {
    super.initState();
    fetchPhotos();
    fetchPlantInformation(widget.plantName!, widget.commonName!).then((value) {
      setState(() {
        para = value;
      });
    }).catchError((error) {
      print('Error fetching plant information: $error');
    });
  }

  void fetchPhotos() async {
    String key = '187eIB9xAk7cmtokC5xYlDc4E6IgAB7f1sm6LLLmfs0';
    String apiUrl =
        'https://api.unsplash.com/search/photos?query=${widget.plantName}&client_id=$key';

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        List<dynamic> photoDataList = data['results'];

        setState(() {
          // Extract URLs and store them in photoUrls list
          photoUrls = photoDataList
              .map((photoData) => photoData['urls']['regular'].toString())
              .toList()
              .take(11) // Take the first 11 URLs only
              .toList();
        });
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
    }
  }

  bool _isValidUrl(String url) {
    return url.isNotEmpty &&
        (url.startsWith("http://") || url.startsWith("https://"));
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool added = false;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const CameraScanner(),
            ),
          ),
        ),
        title: const Text(
          "Plants Information",
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
              value: added,
              onChanged: (bool value) {
                setState(() {
                  added = value;
                  print(added);
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
                  child: photoUrls.isNotEmpty && _isValidUrl(photoUrls[0])
                      ? Image.network(
                          photoUrls[0],
                          height: 250,
                          width: width,
                          fit: BoxFit.fitWidth,
                        )
                      : Container(
                          // Placeholder image when the photoUrls list is empty or URL is invalid
                          height: 250,
                          width: width,
                          color: Colors
                              .grey, // You can customize this placeholder color
                        ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: SizedBox(
                  height: 75,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: photoUrls.length,
                    itemBuilder: (context, index) {
                      if (_isValidUrl(photoUrls[index])) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              photoUrls[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        // Return an empty container or a placeholder image
                        return Container(
                          width: 100,
                          color: Colors.grey, // Customize this color as needed
                        );
                      }
                    },
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.commonName ?? "",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: tSecondTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                          added == false
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
                          added == false
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
              const SizedBox(
                height: 10,
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
        child: added == false
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
                    added = true;
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
                    "Edit My Plants",
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
