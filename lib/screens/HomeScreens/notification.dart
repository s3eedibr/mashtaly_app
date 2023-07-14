import 'package:flutter/material.dart';

import '../../Constants/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: tBgColor,
      body: Center(
        child: Text(
          "Notifications",
          style: TextStyle(fontSize: 35),
        ),
      ),
    );
  }
}
