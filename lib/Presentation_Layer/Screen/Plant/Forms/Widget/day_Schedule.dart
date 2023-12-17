import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../Constants/colors.dart';
import '../Utils.dart';

class DayScheduleWidget extends StatefulWidget {
  final int selectedWeek;

  const DayScheduleWidget(this.selectedWeek, {Key? key}) : super(key: key);

  @override
  State<DayScheduleWidget> createState() => _DayScheduleWidgetState();
}

class _DayScheduleWidgetState extends State<DayScheduleWidget> {
  List<String> weeklySchedules = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  late List<Future<TimeOfDay?>> selectedTimes;
  late List<List<String?>> times; // Modified to List<List<String?>>

  @override
  void initState() {
    super.initState();
    selectedTimes = List.generate(7, (index) => Future.value(TimeOfDay.now()));
    times = List.generate(7, (index) => []);
  }

  void showDialogTimePicker(BuildContext context, int dayIndex) {
    selectedTimes[dayIndex] = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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

    // When the user selects a time, update the state of the widget with the new time value.
    selectedTimes[dayIndex].then((value) {
      setState(() {
        if (value == null) return;
        times[dayIndex].add(Utils.getFormattedTimeSimple(
            DateTime(2023, 1, 1, value.hour, value.minute)
                .millisecondsSinceEpoch));
        // print(times[dayIndex]);
      });
    }, onError: (error) {
      // Handle any errors that occur when selecting a time (e.g. user cancels).
      if (kDebugMode) {
        print(error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 16),
      child: Visibility(
        visible: widget.selectedWeek >= 1 &&
            widget.selectedWeek <= weeklySchedules.length,
        child: SizedBox(
          height: 120,
          width: double.infinity,
          child: ListView.builder(
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final dayName = weeklySchedules[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 12,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: tPrimaryActionColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 8,
                          left: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dayName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 50, // Adjust the height as needed
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: times[index].length,
                                itemBuilder:
                                    (BuildContext context, int timeIndex) {
                                  return Text(
                                    '${times[index][timeIndex]}',
                                    style: const TextStyle(
                                      color: tPrimaryTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialogTimePicker(context, index);
                              },
                              child: const Text(
                                '+  Add Time',
                                style: TextStyle(
                                  color: tPrimaryActionColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
