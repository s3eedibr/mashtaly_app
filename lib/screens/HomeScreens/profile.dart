import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:mashtaly_app/Auth/auth.dart';
import '../../Constants/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: tBgColor,
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              height: 190,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {},
                child: const Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: SizedBox(
                        height: 110,
                        width: 110,
                        child: CircleAvatar(
                          backgroundColor: tPrimaryActionColor,
                          child: CircleAvatar(
                            radius: 54,
                            backgroundImage: AssetImage(
                                'assets/images/icons/default_profile.jpg'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 230,
                      top: 95,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: CircleAvatar(
                          backgroundColor: tPrimaryActionColor,
                          child: CircleAvatar(
                            backgroundColor: tBgColor,
                            radius: 16.5,
                            child: Icon(
                              Icons.mode_edit_rounded,
                              color: tPrimaryActionColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 145),
                      child: Text(
                        'Saeed Ibrahim',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            'assets/images/icons/Group 268.png',
                            height: 38,
                            width: 38,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            'Notification',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      AppSettings.openAppSettings(
                        type: AppSettingsType.notification,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            'assets/images/icons/Group 269.png',
                            height: 38,
                            width: 38,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            'Settings',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            'assets/images/icons/Group 270.png',
                            height: 38,
                            width: 38,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            'Help',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            'assets/images/icons/Group 271.png',
                            height: 38,
                            width: 38,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showDialog(
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
                                'Are you sure to logout?',
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
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
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
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => const Auth(),
                                          ),
                                          (Route<dynamic> route) => false);
                                      FirebaseAuth.instance.signOut();
                                    },
                                    child: const Text(
                                      "Confirm",
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
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
