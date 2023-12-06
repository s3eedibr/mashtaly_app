import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'delayedWateringColumn.dart';
import 'weatherConditionColumn.dart';

Widget buildDelayedWateringInput(
  BuildContext context,
  delayedDateTime,
  showDropdown,
  duration,
  path,
  text,
) {
  return Padding(
    padding: const EdgeInsets.only(
      right: 16,
      bottom: 0,
      left: 17,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildDelayedWateringColumn(
          "Delayed Watering",
          FontAwesomeIcons.plus,
          () {
            delayedDateTime(context);
          },
          duration,
        ),
        buildWeatherConditionColumn(
          "If",
          FontAwesomeIcons.plus,
          () {
            showDropdown(context);
          },
          path,
          text,
        ),
      ],
    ),
  );
}
