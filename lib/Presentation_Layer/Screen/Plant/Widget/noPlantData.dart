import 'package:flutter/material.dart';

class NoPlantData extends StatelessWidget {
  const NoPlantData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          bottom: 88.5,
          top: 15,
          right: 125,
          left: 125,
          child: Image.asset(
            'assets/images/stack_images/Group 2.png',
            height: 102,
            width: 88,
          ),
        ),
        Positioned(
          bottom: 153,
          right: 27,
          left: 235,
          child: Image.asset(
            'assets/images/stack_images/Group 390.png',
            height: 110,
            width: 80,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 180,
            bottom: 13,
          ),
          child: Text(
            textAlign: TextAlign.center,
            "You don't have any plants yet\nAdd your plant now",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
