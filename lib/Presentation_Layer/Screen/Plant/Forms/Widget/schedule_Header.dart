import 'package:flutter/material.dart';

Widget buildScheduleHeader() {
  return const Padding(
    padding: EdgeInsets.only(right: 16, bottom: 0, left: 17),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 35),
        Text(
          "Schedule",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}
