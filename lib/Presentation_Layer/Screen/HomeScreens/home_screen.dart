import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Constants/colors.dart';
import '../CameraScreen/camera_scanner_screen.dart';
import '../Community/community.dart';
import '../Plant/plant.dart';
import 'notification.dart';
import '../Profile/profile.dart';

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
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return Theme(
              data: ThemeData(
                dialogBackgroundColor: Colors.white,
              ),
              child: AlertDialog(
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
              ),
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: currentTap,
          children: screens,
        ),
        floatingActionButton: SizedBox(
          height: 64,
          width: 64,
          child: FloatingActionButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
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
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(64, 212, 0, 0.063),
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
                children: [
                  buildBottomBarButton(0, "Plant", "Path 8.png", "Path 84.png"),
                  buildBottomBarButton(
                      1, "Community", "communities1.png", "communities.png"),
                  buildBottomBarButton(
                      2, "Notifications", "bell (1).png", "bell.png"),
                  buildBottomBarButton(
                      3, "Profile", "Path 64.png", "Path 6.png"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomBarButton(
      int index, String label, String activeImage, String inactiveImage) {
    return MaterialButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentTap = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          currentTap == index
              ? Image.asset(
                  "assets/images/icons/$activeImage",
                  height: 28,
                  width: 28,
                )
              : Image.asset(
                  "assets/images/icons/$inactiveImage",
                  height: 28,
                  width: 28,
                ),
          const SizedBox(height: 7),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight:
                  currentTap == index ? FontWeight.w700 : FontWeight.normal,
              color: currentTap == index
                  ? tPrimaryActionColor
                  : tSecondActionColor,
            ),
          )
        ],
      ),
    );
  }
}
