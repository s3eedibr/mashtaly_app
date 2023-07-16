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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CameraScanner(),
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
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
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
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
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
                            color:
                                Colors.grey, // Customize this color as needed
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.plantName ?? "",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.ellipsisVertical,
                                color: tSecondTextColor,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.commonName ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: tSecondTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          para,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
