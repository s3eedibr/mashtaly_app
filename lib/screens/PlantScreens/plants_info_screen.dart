// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Services/wikipedia_service.dart';

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

  @override
  void initState() {
    super.initState();
    fetchPlantInformation(widget.plantName!, widget.commonName!).then((value) {
      setState(() {
        para = value;
      });
    }).catchError((error) {
      print('Error fetching plant information: $error');
    });
  }

  List<String> images = [
    'assets/images/plants_info_images/0a6c1f051b5d941f4f2056b417403f9c5a5c4102.jpg',
    'assets/images/plants_info_images/1c3de460830f2028d5666fc8db1db3f0d4bfb5c7.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
    'assets/images/plants_info_images/2a87b3553b6cbd9a030bf64586bd95f77e049f6a.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () => Navigator.of(context).pop(),
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
                  child: Image.asset(
                    'assets/images/plants_info_images/3d74853a74cef709e1750aa4f7083c55dee7f616.jpg',
                    height: 250,
                    width: width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 75,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            images[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.plantName ?? "",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.ellipsisVertical,
                        color: tSecondTextColor,
                        size: 20,
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
        ],
      ),
    );
  }
}
