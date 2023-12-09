import 'package:flutter/material.dart';

import '../../../../Constants/colors.dart';
import '../Forms/form_without_Sensor.dart';
import '../Forms/form_with_Sensor.dart';

// Function to show a bottom sheet with choice buttons for adding a plant.
Future<dynamic> showChoiceButtonsAddPlant(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return Container(
        height: 225,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 0, left: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column for "With Sensor" option
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container for the button with a sensor icon
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: tPrimaryActionColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Navigate to the form with sensor
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPlantFormWithSen(),
                          ),
                        );
                      },
                      highlightColor: Colors.white.withOpacity(0.05),
                      icon: Image.asset(
                        'assets/images/icons/smart-farm.png',
                        height: 65,
                        width: 65,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'With Sensor',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              // Column for "Without Sensor" option
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  // Container for the button without a sensor icon
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: tPrimaryActionColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Navigate to the form without sensor
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AddPlantFormWithOutSen(),
                          ),
                        );
                      },
                      highlightColor: Colors.white.withOpacity(0.05),
                      icon: Image.asset(
                        'assets/images/icons/Untitled-3@3x.png',
                        height: 65,
                        width: 65,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Additional information for the "Without Sensor" option
                  const Column(
                    children: [
                      Text(
                        'Without Sensor',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Mashtaly Data',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
