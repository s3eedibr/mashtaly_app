import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../../Constants/colors.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  String? title = message.notification!.title;
  String? body = message.notification!.body;
  AwesomeNotifications().createNotification(
    // schedule: NotificationAndroidCrontab.minutely(
    //   referenceDateTime: DateTime.now(),
    // ),
    content: NotificationContent(
        displayOnForeground: true,
        displayOnBackground: true,
        id: 123,
        channelKey: 'call_channel',
        color: tBgColor,
        title: title,
        body: body,
        category: NotificationCategory.Message,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: tPrimaryActionColor),
  );
}

Future<bool> notificationInitialize() {
  return AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'call_channel',
        channelName: 'call_channel',
        channelDescription: 'channel of calling',
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        playSound: true,
        onlyAlertOnce: true,
        defaultRingtoneType: DefaultRingtoneType.Notification)
  ]);
}

void getForegroundNotification() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String? title = message.notification!.title;
    String? body = message.notification!.body;
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 123,
          channelKey: 'call_channel',
          color: tBgColor,
          title: title,
          body: body,
          category: NotificationCategory.Message,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: tPrimaryActionColor),
    );
  });
}

Future<void> changeUserToken() async {
  try {
    Future<String> getToken() async {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token == null) return '';
      return token;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'token': await getToken()});
  } catch (e) {
    e;
  }
}

Future<void> scheduleNotificationsFromFirestore() async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('scheduleData')
        .doc('En8vTOBZf1e9cZfHqXsh')
        .get();

    String scheduledTimeString = documentSnapshot['scheduledTime'] as String;

    DateTime scheduledTime = DateTime.parse(scheduledTimeString);

    AwesomeNotifications().createNotification(
      schedule: NotificationAndroidCrontab.daily(
        referenceDateTime: scheduledTime,
      ),
      content: NotificationContent(
        displayOnForeground: true,
        displayOnBackground: true,
        id: 123,
        channelKey: 'call_channel',
        color: tBgColor,
        title: 'Scheduled Notification',
        body: 'This is a scheduled notification.',
        category: NotificationCategory.Message,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: tPrimaryActionColor,
      ),
    );
  } catch (e) {
    print('Error scheduling notifications: $e');
  }
}
