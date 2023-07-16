import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_app/Screens/HomeScreens/camera_scanner_screen.dart';
import 'package:mashtaly_app/Screens/HomeScreens/community.dart';
import 'package:mashtaly_app/Screens/HomeScreens/notification.dart';
import 'package:mashtaly_app/Screens/HomeScreens/plant.dart';
import 'package:mashtaly_app/Screens/HomeScreens/profile.dart';

import '../../Constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTap = 0;
  final List<Widget> screens = [
    const PlantScreen(),
    const CommunityScreen(),
    const CameraScanner(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const PlantScreen();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
              titlePadding: const EdgeInsets.only(
                right: 16,
                bottom: 15,
                left: 16,
                top: 15,
              ),
              title: const Text(
                'Do you want to go back?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actionsPadding: const EdgeInsets.only(
                right: 16,
                bottom: 15,
                left: 16,
              ),
              actions: [
                SizedBox(
                  height: 45,
                  width: 120,
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: tPrimaryActionColor,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: tPrimaryActionColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryActionColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: SafeArea(
        child: Scaffold(
          body: PageStorage(
            bucket: bucket,
            child: currentScreen,
          ),
          floatingActionButton: SizedBox(
              height: 64,
              width: 64,
              child: FloatingActionButton(
                backgroundColor: tPrimaryActionColor,
                shape: const CircleBorder(),
                child: Image.asset(
                  "assets/images/icons/Path 7.png",
                  height: 26,
                  width: 26,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraScanner(),
                    ),
                  );
                },
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x10000000),
                  blurRadius: 25,
                ),
              ],
            ),
            child: BottomAppBar(
              height: 80,
              color: Colors.white,
              elevation: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const CircularNotchedRectangle(),
              notchMargin: 12,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const PlantScreen();
                              currentTap = 0;
                            });
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                currentTap == 0
                                    ? Image.asset(
                                        "assets/images/icons/Path 8.png",
                                        height: 28,
                                        width: 28,
                                      )
                                    : Image.asset(
                                        "assets/images/icons/Path 84.png",
                                        height: 28,
                                        width: 28,
                                      ),
                                const SizedBox(height: 7),
                                Text(
                                  "Plant",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: currentTap == 0
                                        ? FontWeight.w700
                                        : FontWeight.normal,
                                    color: currentTap == 0
                                        ? tPrimaryActionColor
                                        : tSecondActionColor,
                                  ),
                                )
                              ]),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const CommunityScreen();
                              currentTap = 1;
                            });
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                currentTap == 1
                                    ? Image.asset(
                                        "assets/images/icons/communities1.png",
                                        height: 32,
                                        width: 32,
                                      )
                                    : Image.asset(
                                        "assets/images/icons/communities.png",
                                        height: 32,
                                        width: 32,
                                      ),
                                const SizedBox(height: 5),
                                Text(
                                  "Community",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: currentTap == 1
                                        ? FontWeight.w700
                                        : FontWeight.normal,
                                    color: currentTap == 1
                                        ? tPrimaryActionColor
                                        : tSecondActionColor,
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const NotificationScreen();
                              currentTap = 2;
                            });
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                currentTap == 2
                                    ? Image.asset(
                                        "assets/images/icons/bell (1).png",
                                        height: 28,
                                        width: 28,
                                      )
                                    : Image.asset(
                                        "assets/images/icons/bell.png",
                                        height: 28,
                                        width: 28,
                                      ),
                                const SizedBox(height: 7),
                                Text(
                                  "Notifications",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: currentTap == 2
                                        ? FontWeight.w700
                                        : FontWeight.normal,
                                    color: currentTap == 2
                                        ? tPrimaryActionColor
                                        : tSecondActionColor,
                                  ),
                                )
                              ]),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const ProfileScreen();
                              currentTap = 3;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              currentTap == 3
                                  ? Image.asset(
                                      "assets/images/icons/Path 64.png",
                                      height: 28,
                                      width: 28,
                                    )
                                  : Image.asset(
                                      "assets/images/icons/Path 6.png",
                                      height: 28,
                                      width: 28,
                                    ),
                              const SizedBox(height: 7),
                              Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: currentTap == 3
                                      ? FontWeight.w700
                                      : FontWeight.normal,
                                  color: currentTap == 3
                                      ? tPrimaryActionColor
                                      : tSecondActionColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
