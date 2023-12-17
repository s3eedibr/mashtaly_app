import 'package:flutter/material.dart';
import 'delayed_Watering_Column.dart';
import 'weather_Condition_Column.dart';

class DelayedWateringInput extends StatefulWidget {
  final dynamic delayedDuration;
  final dynamic delayedWeather;
  const DelayedWateringInput({
    super.key,
    this.delayedDuration,
    this.delayedWeather,
  });

  @override
  State<DelayedWateringInput> createState() => _DelayedWateringInputState();
}

class _DelayedWateringInputState extends State<DelayedWateringInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DelayedWateringColumn(durationList: widget.delayedDuration),
        WeatherConditionColumn(conditionList: widget.delayedWeather),
      ],
    );
  }
}
