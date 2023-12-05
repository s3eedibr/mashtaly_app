import 'package:flutter/material.dart';

import '../../../../../Constants/colors.dart';

Widget buildWateringSizeInput(amountOfWaterController) {
  return Padding(
    padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 25),
        const Text(
          "Amount of water per watering",
          style: TextStyle(
            fontSize: 15,
            color: Color(0x7C0D1904),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          width: 375,
          child: TextFormField(
            controller: amountOfWaterController,
            keyboardType: TextInputType.number,
            cursorColor: tPrimaryActionColor,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 15,
              ),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
