import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          title: isSearching
              ? SizedBox(
                  height: 40,
                  child: TextField(
                    cursorColor: tPrimaryActionColor,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: tSearchBarColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 15,
                      ),
                    ),
                    onSubmitted: (value) {
                      // Handle search here
                    },
                  ),
                )
              : const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          actions: [
            IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: Icon(
                isSearching ? Icons.close : Icons.search_rounded,
                color: tSearchIconColor, // Change the color as needed
                size: 27,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {},
              icon: const Icon(
                Icons.filter_list_rounded,
                color: tSearchIconColor, // Change the color as needed
                size: 27,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return const notificationCard();
          },
        ),
      ),
    );
  }
}
