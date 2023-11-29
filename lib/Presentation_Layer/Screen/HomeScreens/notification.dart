import 'package:flutter/material.dart';
import 'package:mashtaly_app/Presentation_Layer/Screen/Community/Widget/appBar.dart';

import '../../Widget/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Notifications'),
      body: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          return const notificationCard();
        },
      ),
    );
  }
}
