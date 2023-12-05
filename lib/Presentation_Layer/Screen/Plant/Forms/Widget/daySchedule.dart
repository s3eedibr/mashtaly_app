import 'package:flutter/material.dart';

import '../../../../../Constants/colors.dart';

Widget buildDaySchedule(
    selectedWeek, weeklySchedules, showDialogTimePicker, time) {
  return Padding(
    padding: const EdgeInsets.only(left: 17, right: 16),
    child: Visibility(
      visible: selectedWeek >= 1 && selectedWeek <= weeklySchedules.length,
      child: SizedBox(
        height: 92,
        width: double.infinity,
        child: ListView.builder(
          itemCount: 7,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            final dayNames = weeklySchedules[selectedWeek - 1];
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
                    height: 80,
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
                            dayNames[index],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialogTimePicker(context);
                            },
                            child: time == null
                                ? const Text(
                                    '+  Add Time',
                                    style: TextStyle(
                                      color: tPrimaryActionColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    '$time',
                                    style: const TextStyle(
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
