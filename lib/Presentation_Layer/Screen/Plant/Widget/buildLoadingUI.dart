import 'package:flutter/material.dart';

import '../../../../Constants/colors.dart';

Widget buildLoadingUI() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/plant_loading2.gif",
          height: 100,
          width: 100,
        ),
        const SizedBox(height: 16),
        const Text(
          'Loading...',
          style: TextStyle(
            color: tPrimaryTextColor,
            fontFamily: 'Mulish',
            decoration: TextDecoration.none,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
