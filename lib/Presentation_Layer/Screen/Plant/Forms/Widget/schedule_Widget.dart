import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../Constants/colors.dart';
import '../Utils.dart';

class DayScheduleWidget extends StatefulWidget {
  final int selectedWeek;
  final List<List<dynamic>>? scheduleData;
  const DayScheduleWidget(this.selectedWeek, {Key? key, this.scheduleData})
      : super(key: key);

  @override
  State<DayScheduleWidget> createState() => _DayScheduleWidgetState();
}

List<dynamic> timeInEachWeekAndDay = [];

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

  late List<List<Future<dynamic>>> selectedTimesList;
  late List<List<List<String?>>> timesList = [];
  List<List<dynamic>>? editedValue = [];

  @override
  void initState() {
    super.initState();
    selectedTimesList = List.generate(
        4,
        (weekIndex) =>
            List.generate(7, (dayIndex) => Future.value(TimeOfDay.now())));
    timesList = List.generate(4,
        (weekIndex) => List.generate(7, (dayIndex) => [])); // 4 weeks, 7 days

    editedValue = widget.scheduleData;
  }

  void showDialogTimePicker(BuildContext context, int weekIndex, int dayIndex) {
    // print(editedValue);
    selectedTimesList[weekIndex][dayIndex] = showTimePicker(
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
    selectedTimesList[weekIndex][dayIndex].then((value) async {
      setState(() {
        if (value == null) return;
        String formattedTime = Utils.getFormattedTimeSimple(
            DateTime(2023, 1, 1, value.hour, value.minute)
                .millisecondsSinceEpoch);
        timesList[weekIndex][dayIndex].add(formattedTime);

        timeInEachWeekAndDay.add([weekIndex, dayIndex, formattedTime]);
        // print(timesList[weekIndex][dayIndex]);
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 16),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: ListView.builder(
          itemCount: 7,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int dayIndex) {
            final dayName = weeklySchedules[dayIndex];
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
                        right: 9,
                        left: 9,
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
                              itemCount: timesList[widget.selectedWeek - 1]
                                      [dayIndex]
                                  .length,
                              itemBuilder:
                                  (BuildContext context, int timeIndex) {
                                return Text(
                                  '${timesList[widget.selectedWeek - 1][dayIndex][timeIndex]}',
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
                              showDialogTimePicker(
                                  context, widget.selectedWeek - 1, dayIndex);
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
    );
  }
}

class WeekButtonsWidget extends StatefulWidget {
  final int selectedWeek;
  final ValueChanged<int> onWeekSelected;

  const WeekButtonsWidget({
    required this.selectedWeek,
    required this.onWeekSelected,
    Key? key,
  }) : super(key: key);

  @override
  _WeekButtonsWidgetState createState() => _WeekButtonsWidgetState();
}

class _WeekButtonsWidgetState extends State<WeekButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 16),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final List<String> weekNum = [
              'Week 1',
              'Week 2',
              'Week 3',
              'Week 4'
            ];
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  widget.onWeekSelected(index + 1);
                },
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: widget.selectedWeek == index + 1
                        ? tPrimaryActionColor
                        : tBgColor,
                    border: widget.selectedWeek == index + 1
                        ? Border.all(color: Colors.transparent)
                        : Border.all(width: 1, color: tSearchIconColor),
                  ),
                  child: Center(
                    child: Text(
                      weekNum[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: widget.selectedWeek == index + 1
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: widget.selectedWeek == index + 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ScheduleWidget extends StatefulWidget {
  final List<List<dynamic>>? scheduleData;
  const ScheduleWidget({Key? key, this.scheduleData}) : super(key: key);

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  int selectedWeek = 1;
  List<List<dynamic>>? editedValue = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (widget.scheduleData!.isNotEmpty) {
    //   editedValue = widget.scheduleData;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WeekButtonsWidget(
          selectedWeek: selectedWeek,
          onWeekSelected: (week) {
            setState(() {
              selectedWeek = week;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        DayScheduleWidget(
          selectedWeek,
          scheduleData: editedValue,
        ),
      ],
    );
  }
}
