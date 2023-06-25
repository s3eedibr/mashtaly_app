import 'package:flutter/material.dart';

import '../../Constants/colors.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  bool newNotification = false;
  @override
  Widget build(BuildContext context) {
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
                    padding:
                        const EdgeInsets.only(right: 8, bottom: 0, left: 16),
                    child: TextField(
                      cursorColor: tPrimaryActionColor,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: tSearchBarColor,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
            padding: const EdgeInsets.only(right: 16, bottom: 0, left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud_queue_rounded,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Heavy Rain",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.insert_chart_outlined_rounded,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "16°c",
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
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 0, left: 16),
              child: SizedBox(
                height: 88,
                child: DatePicker(
                  DateTime.now(),
                  height: 50,
                  width: 53,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: tPrimaryActionColor,
                  selectedTextColor: Colors.white,
                  dateTextStyle: const TextStyle(
                    fontSize: 20,
                  ),
                  daysCount: 7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
