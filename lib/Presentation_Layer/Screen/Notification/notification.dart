import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';
import 'notification_card.dart';
import '../Community/Widget/appBar.dart';
import '../Plant/Forms/Utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<Map<String, dynamic>?>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = getNotifications();
  }

  Future<List<Map<String, dynamic>?>> getNotifications() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('notification')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Notification')
              .orderBy('date', descending: true)
              .get();

      return querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) =>
              document.data())
          .toList();
    } catch (e) {
      print('Error getting notifications: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Notifications'),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            notifications = getNotifications();
          });
        },
        color: tPrimaryActionColor,
        backgroundColor: tBgColor,
        child: FutureBuilder<List<Map<String, dynamic>?>>(
          future: notifications,
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>?>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            final List<Map<String, dynamic>?> notificationData =
                snapshot.data ?? [];

            if (notificationData.isEmpty) {
              return const Center(
                child: Text('No notifications found.'),
              );
            }

            return ListView.builder(
              itemCount: notificationData.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic>? data = notificationData[index];
                String formattedDate =
                    Utils.getTimeAgo(data?['date']?.toString() ?? '');
                return NotificationCard(
                  title: data?['title'] ?? '',
                  desc: ' ${data?['content'] ?? ''}',
                  type: data?['type'] ?? '',
                  date: formattedDate,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
