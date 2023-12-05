import 'package:flutter/material.dart';

import '../../../../../Constants/colors.dart';

Widget buildWeatherConditionColumn(
    String labelText, IconData icon, VoidCallback onTap, path, text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 25),
      Text(
        labelText,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0x7C0D1904),
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 5),
      GestureDetector(
        onTap: onTap,
        child: path != null && text != null
            ? Container(
                height: 40,
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Image.asset(path),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 15,
                          color: tPrimaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 40,
                width: 150,
                decoration: const BoxDecoration(
                  color: Color(0xffD2D8CF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
      ),
    ],
  );
}
