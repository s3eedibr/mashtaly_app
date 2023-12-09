import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Constants/colors.dart';

class DelayedWateringColumn extends StatefulWidget {
  const DelayedWateringColumn({super.key});

  @override
  State<DelayedWateringColumn> createState() => _DelayedWateringColumnState();
}

List<List<int>> duration = [];

class _DelayedWateringColumnState extends State<DelayedWateringColumn> {
  DateTime delayedDate = DateTime.now();
  TimeOfDay delayedTime = TimeOfDay.now();

  Future<void> delayedDateTime() async {
    DateTime initialDate = delayedDate;
    TimeOfDay initialTime = delayedTime;

    DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: tPrimaryActionColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: tPrimaryTextColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateTime != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: tPrimaryActionColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: tPrimaryTextColor,
              ),
            ),
            child: child!,
          );
        },
      );
      int removedIndex = 0;

      if (pickedTime != null) {
        pickedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          delayedDate = pickedDateTime!;
          delayedTime = pickedTime;
          print(pickedDateTime);
          print(pickedTime);
          removedIndex = duration.indexWhere((item) =>
              item[0] == currentValue[0] && item[1] == currentValue[1]);

          if (removedIndex != -1) {
            duration.removeWhere((item) =>
                item[0] == currentValue[0] && item[1] == currentValue[1]);
            duration.insert(removedIndex, calculateDuration());
          } else {
            // Add the new calculated duration
            duration.add(calculateDuration());
          }
          // Remove existing item if it exists

          print(calculateDuration());
        });
      }
    }
  }

  List<int> calculateDuration() {
    // Calculate the total duration in days and hours
    DateTime now = DateTime.now();
    DateTime selectedDateTime = DateTime(
      delayedDate.year,
      delayedDate.month,
      delayedDate.day,
      delayedTime.hour,
      delayedTime.minute,
    );

    Duration selectedDuration = selectedDateTime.difference(now);

    // Calculate days and hours separately
    int days = selectedDuration.inDays;
    int hours = selectedDuration.inHours % 24;

    return [days, hours];
  }

  List<int> currentValue = [];

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
              delayedDateTime();
              currentValue = [calculateDuration()[0], calculateDuration()[1]];
              print(currentValue);
            },
            child: Container(
              height: 40,
              width: 170,
              decoration: const BoxDecoration(
                color: Color(0xffD2D8CF),
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: calculateDuration()[0] != 0 || calculateDuration()[1] != 0
                  ? Container(
                      height: 40,
                      width: 150,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${calculateDuration()[0]} days, ${calculateDuration()[1]} hours',
                          style: const TextStyle(
                            color: tPrimaryTextColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  : const Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
