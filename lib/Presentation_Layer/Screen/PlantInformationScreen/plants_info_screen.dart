// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Services/wikipedia_service.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../../Constants/colors.dart';

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
  bool switchValue = false;

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
              .take(6) // Take the first 6 URLs only
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(
        //       left: 16,
        //       right: 16,
        //     ),
        //     child: Switch(
        //       value: switchValue,
        //       onChanged: (newValue) {
        //         setState(() {
        //           switchValue = newValue;
        //           print(switchValue);
        //         });
        //       },
        //       activeTrackColor: const Color(0xff9BEC79),
        //       activeColor: const Color(0xff66B821),
        //       inactiveTrackColor: const Color(0xFFFF3324),
        //       inactiveThumbColor: tBgColor,
        //       trackOutlineColor:
        //           const MaterialStatePropertyAll<Color?>(Colors.transparent),
        //     ),
        //   ),
        // ],
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
                      ? CachedNetworkImage(
                          imageUrl: photoUrls[0],
                          height: 250,
                          width: width,
                          fit: BoxFit.fitWidth,
                          placeholder: (BuildContext context, String url) =>
                              const Center(
                                  child: CircularProgressIndicator(
                            color: tPrimaryActionColor,
                          )),
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              const Center(
                            child: Icon(Icons.image_not_supported_outlined),
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
                            borderRadius: BorderRadius.circular(6),
                            child: photoUrls.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: photoUrls[index],
                                    height: 95,
                                    width: 85,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (BuildContext context, String url) =>
                                            const Center(
                                                child: SizedBox(
                                      height: 55,
                                      width: 55,
                                      child: CircularProgressIndicator(
                                        color: tPrimaryActionColor,
                                      ),
                                    )),
                                    errorWidget: (BuildContext context,
                                            String url, dynamic error) =>
                                        const Center(
                                      child: Icon(
                                          Icons.image_not_supported_outlined),
                                    ),
                                  )
                                : Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 95,
                                      width: 85,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                    ),
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
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: SizedBox(
      //   height: 50,
      //   width: 380,
      //   child: switchValue == false
      //       ? FloatingActionButton(
      //           backgroundColor: tPrimaryActionColor,
      //           elevation: 0,
      //           shape: const RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(
      //               Radius.circular(12.0),
      //             ),
      //           ),
      //           onPressed: () {
      //             setState(() {
      //               switchValue = true;
      //             });
      //           },
      //           child: const Center(
      //               child: Text(
      //             "Add to My Plants",
      //             style: TextStyle(
      //               color: tThirdTextColor,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 20,
      //             ),
      //           )),
      //         )
      //       : FloatingActionButton(
      //           backgroundColor: tThirdTextErrorColor,
      //           elevation: 0,
      //           shape: const RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(
      //               Radius.circular(12.0),
      //             ),
      //           ),
      //           onPressed: () {},
      //           child: const Center(
      //             child: Text(
      //               "Edit My Plant",
      //               style: TextStyle(
      //                 color: tThirdTextColor,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 20,
      //               ),
      //             ),
      //           ),
      //         ),
      // ),
    );
  }
}
