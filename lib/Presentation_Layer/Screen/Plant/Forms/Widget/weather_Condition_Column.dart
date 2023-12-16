import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../Constants/colors.dart';
import 'custom_Dropdown.dart';

class WeatherConditionColumn extends StatefulWidget {
  final dynamic ConditionList;
  const WeatherConditionColumn({
    Key? key,
    this.ConditionList,
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

  String? getSelectedImagePath(String? selectedWeatherText) {
    if (selectedWeatherText == null) return null;

    final weatherData = [
      ['Sunny', 'Clear', 113],
      ['Partly cloudy', 'Partly cloudy', 116],
      ['Cloudy', 'Cloudy', 119],
      ['Overcast', 'Overcast', 122],
      ['Mist', 'Mist', 143],
      ['Patchy rain possible', 'Patchy rain possible', 176],
      ['Patchy snow possible', 'Patchy snow possible', 179],
      ['Patchy sleet possible', 'Patchy sleet possible', 182],
      [
        'Patchy freezing drizzle possible',
        'Patchy freezing drizzle possible',
        185
      ],
      ['Thundery outbreaks possible', 'Thundery outbreaks possible', 200],
      ['Blowing snow', 'Blowing snow', 227],
      ['Blizzard', 'Blizzard', 230],
      ['Fog', 'Fog', 248],
      ['Freezing fog', 'Freezing fog', 260],
      ['Patchy light drizzle', 'Patchy light drizzle', 263],
      ['Light drizzle', 'Light drizzle', 266],
      ['Freezing drizzle', 'Freezing drizzle', 281],
      ['Heavy freezing drizzle', 'Heavy freezing drizzle', 284],
      ['Patchy light rain', 'Patchy light rain', 293],
      ['Light rain', 'Light rain', 296],
      ['Moderate rain at times', 'Moderate rain at times', 299],
      ['Moderate rain', 'Moderate rain', 302],
      ['Heavy rain at times', 'Heavy rain at times', 305],
      ['Heavy rain', 'Heavy rain', 308],
      ['Light freezing rain', 'Light freezing rain', 311],
      [
        'Moderate or heavy freezing rain',
        'Moderate or heavy freezing rain',
        314
      ],
      ['Light sleet', 'Light sleet', 317],
      ['Moderate or heavy sleet', 'Moderate or heavy sleet', 320],
      ['Patchy light snow', 'Patchy light snow', 323],
      ['Light snow', 'Light snow', 326],
      ['Patchy moderate snow', 'Patchy moderate snow', 329],
      ['Moderate snow', 'Moderate snow', 332],
      ['Patchy heavy snow', 'Patchy heavy snow', 335],
      ['Heavy snow', 'Heavy snow', 338],
      ['Ice pellets', 'Ice pellets', 350],
      ['Light rain shower', 'Light rain shower', 353],
      ['Moderate or heavy rain shower', 'Moderate or heavy rain shower', 356],
      ['Torrential rain shower', 'Torrential rain shower', 359],
      ['Light sleet showers', 'Light sleet showers', 362],
      [
        'Moderate or heavy sleet showers',
        'Moderate or heavy sleet showers',
        365
      ],
      ['Light snow showers', 'Light snow showers', 368],
      ['Moderate or heavy snow showers', 'Moderate or heavy snow showers', 371],
      ['Light showers of ice pellets', 'Light showers of ice pellets', 374],
      [
        'Moderate or heavy showers of ice pellets',
        'Moderate or heavy showers of ice pellets',
        377
      ],
      ['Patchy light rain with thunder', 'Patchy light rain with thunder', 386],
      [
        'Moderate or heavy rain with thunder',
        'Moderate or heavy rain with thunder',
        389
      ],
      ['Patchy light snow with thunder', 'Patchy light snow with thunder', 392],
      [
        'Moderate or heavy snow with thunder',
        'Moderate or heavy snow with thunder',
        395
      ],
    ];

    for (var data in weatherData) {
      if (data[0] == selectedWeatherText) {
        return 'assets/images/weather_cond/day/${data[2].toString()}.png';
      } else if (data[1] == selectedWeatherText) {
        return 'assets/images/weather_cond/night/${data[2].toString()}.png';
      }
    }

    return null;
  }

  List<String?> currentValue = [];
  dynamic editedValue;

  @override
  void initState() {
    super.initState();
    editedValue = widget.ConditionList;
    if (editedValue != null) {
      selectedImagePath = getSelectedImagePath(widget.ConditionList[0]);
    }
  }

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
                          child: editedValue == null
                              ? Text(
                                  selectedWeatherText!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: tPrimaryTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Text(
                                  editedValue[0]!,
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
