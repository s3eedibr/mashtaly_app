import 'package:flutter/material.dart';

import '../../Constants/colors.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      body: Center(
        child: Text(
          "Plant",
          style: TextStyle(fontSize: 35),
        ),
      ),
    );
  }
}
