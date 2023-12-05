import 'package:flutter/material.dart';
import 'package:mashtaly_app/Constants/colors.dart';

Widget buildDelayedWateringColumn(
  String labelText,
  IconData icon,
  VoidCallback onTap,
  duration,
) {
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
        child: Container(
          height: 40,
          width: 170,
          decoration: const BoxDecoration(
            color: Color(0xffD2D8CF),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: duration != '0 days, 0 hours'
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
                      '$duration',
                      style: const TextStyle(
                          color: tPrimaryTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
                )
              : Icon(
                  icon,
                  color: Colors.white,
                ),
        ),
      ),
    ],
  );
}
