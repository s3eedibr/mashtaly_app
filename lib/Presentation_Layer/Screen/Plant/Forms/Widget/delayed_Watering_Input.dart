import 'package:flutter/material.dart';
import 'delayed_Watering_Column.dart';
import 'weather_Condition_Column.dart';

class DelayedWateringInput extends StatelessWidget {
  const DelayedWateringInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DelayedWateringColumn(),
        WeatherConditionColumn(),
      ],
    );
  }
}
