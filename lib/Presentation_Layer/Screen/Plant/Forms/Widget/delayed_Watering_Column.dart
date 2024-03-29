import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mashtaly_app/Constants/colors.dart';

class DelayedWateringColumn extends StatefulWidget {
  final dynamic durationList;
  const DelayedWateringColumn({
    super.key,
    this.durationList,
  });

  @override
  State<DelayedWateringColumn> createState() => _DelayedWateringColumnState();
}

List<List<int>> duration = [];
List<List<int>> editedDuration = [];

class _DelayedWateringColumnState extends State<DelayedWateringColumn> {
  DateTime delayedDate = DateTime.now();
  TimeOfDay delayedTime = TimeOfDay.now();
  DateTime forDuration = DateTime.now();

  dynamic editedValue;
  @override
  void initState() {
    super.initState();
    editedValue = widget.durationList;
    if (editedValue != null) {
      currentValue = [editedValue[1], editedValue[2], editedValue[3]];
    }
  }

  Future<void> delayedDateTime() async {
    DateTime initialDate = DateTime.now();
    TimeOfDay initialTime = TimeOfDay.now();

    DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
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
      // ignore: use_build_context_synchronously
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
          // print(pickedDateTime);
          // print(pickedTime);
          if (editedValue == null) {
            removedIndex = duration.indexWhere((item) =>
                item[0] == currentValue[0] &&
                item[1] == currentValue[1] &&
                item[2] == currentValue[2]);

            if (removedIndex != -1) {
              duration.removeWhere((item) =>
                  item[0] == currentValue[0] &&
                  item[1] == currentValue[1] &&
                  item[2] == currentValue[2]);
              duration.insert(removedIndex, calculateDuration());
            } else {
              // Add the new calculated duration
              duration.add(calculateDuration());
            }
          } else {
            removedIndex = editedValue.indexWhere((item) =>
                item == currentValue[0] &&
                item == currentValue[1] &&
                item == currentValue[2]);

            if (removedIndex != -1) {
              editedValue.removeAt((item) =>
                  item == currentValue[0] &&
                  item == currentValue[1] &&
                  item == currentValue[2]);
              editedValue.removeWhere((item) =>
                  item == currentValue[0] &&
                  item == currentValue[1] &&
                  item == currentValue[2]);
              editedValue.insert(removedIndex, calculateDuration());
            } else {
              // Add the new calculated duration
              duration.add(calculateDuration());
            }
          }

          // print(calculateDuration());
        });
      }
    }
  }

  List<int> calculateDuration() {
    // Calculate the total duration in days and hours
    DateTime selectedDateTime = DateTime(
      delayedDate.year,
      delayedDate.month,
      delayedDate.day,
      delayedTime.hour,
      delayedTime.minute,
    );

    Duration selectedDuration = selectedDateTime.difference(forDuration);

    // Calculate days and hours separately
    int days = selectedDuration.inDays;
    int hours = selectedDuration.inHours % 24;
    int minutes = selectedDuration.inMinutes % 60;
    return [days, hours, minutes];
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
              if (editedValue == null) {
                currentValue = [
                  calculateDuration()[0],
                  calculateDuration()[1],
                  calculateDuration()[2],
                ];
                // print(currentValue);
              } else {
                currentValue = [
                  editedValue[1],
                  editedValue[2],
                  editedValue[3],
                ];
                // print(currentValue);
              }
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
              child: calculateDuration()[0] != 0 ||
                      calculateDuration()[1] != 0 ||
                      calculateDuration()[2] != 0
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
                          '${calculateDuration()[0]} days ${calculateDuration()[1]}hr ${calculateDuration()[2]}min',
                          style: const TextStyle(
                            color: tPrimaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  : editedValue != null
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
                              '${editedValue[1]} days ${editedValue[2]}hr ${editedValue[3]}min',
                              style: const TextStyle(
                                color: tPrimaryTextColor,
                                fontWeight: FontWeight.w600,
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
