// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mashtaly_app/Models/notification_card.dart';
import 'package:mashtaly_app/Screens/HomeScreens/home_screen.dart';

import '../../Constants/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            ),
          ),
          title: const Text(
            "Notifications",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search_rounded,
                color: tSearchIconColor,
                size: 27,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.filter_list_rounded,
                color: tSearchIconColor,
                size: 27,
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return notificationCard();
          },
        ),
      ),
    );
  }
}
