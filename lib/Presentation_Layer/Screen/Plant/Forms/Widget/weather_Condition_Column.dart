import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../Constants/colors.dart';
import 'custom_Dropdown.dart';

class WeatherConditionColumn extends StatefulWidget {
  const WeatherConditionColumn({
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherConditionColumn> createState() => _WeatherConditionColumnState();
}

List<String?> weatherCondition = [];

class _WeatherConditionColumnState extends State<WeatherConditionColumn> {
  String? selectedImagePath;
  String? selectedWeatherText;
  int removedIndex = 0;
  Future<void> showDropdown() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          contentPadding: const EdgeInsets.only(left: 16, right: 17),
          content: CustomDropdown(
            onChange: (Map<String, dynamic>? selectedItem) {
              if (selectedItem != null) {
                setState(() {
                  selectedImagePath = selectedItem['path'] as String?;
                  selectedWeatherText = selectedItem['text'] as String?;
                  removedIndex = weatherCondition
                      .indexWhere((item) => item == currentValue[0]);

                  if (removedIndex != -1) {
                    weatherCondition
                        .removeWhere((item) => item == currentValue[0]);
                    weatherCondition.insert(removedIndex, selectedWeatherText);
                  } else {
                    weatherCondition.add(selectedWeatherText);
                  }
                });
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }

  List<String?> currentValue = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        bottom: 0,
        left: 17,
        top: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              showDropdown();
              currentValue = [selectedWeatherText];
              print(currentValue);
            },
            child: (selectedImagePath != null)
                ? Container(
                    height: 40,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset(selectedImagePath!),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedWeatherText!,
                            style: const TextStyle(
                              fontSize: 15,
                              color: tPrimaryTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 40,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Color(0xffD2D8CF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                  ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
