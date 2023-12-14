import 'package:flutter/material.dart';
import '../../../../../Constants/colors.dart';

class WeatherConditionColumn extends StatefulWidget {
  final String? selectedWeatherText;

  const WeatherConditionColumn({
    Key? key,
    this.selectedWeatherText,
  }) : super(key: key);

  @override
  State<WeatherConditionColumn> createState() => _WeatherConditionColumnState();
}

class _WeatherConditionColumnState extends State<WeatherConditionColumn> {
  String? selectedImagePath;

  @override
  void initState() {
    super.initState();
    selectedImagePath = getSelectedImagePath(widget.selectedWeatherText);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 150,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              if (selectedImagePath != null) Image.asset(selectedImagePath!),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.selectedWeatherText!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: tPrimaryTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
