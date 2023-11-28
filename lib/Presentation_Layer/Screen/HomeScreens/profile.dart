import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../Auth/auth.dart';
import '../../../Constants/colors.dart';
import '../../Widget/sankBar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String currentUserUid;
  late DocumentSnapshot userDoc;
  late String userName = '';
  late String profilePic = '';

  @override
  void initState() {
    super.initState();
    currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // Handle no internet connection
        showSnakBar(context, 'No internet connection');
        return;
      }

      userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .get();
      setState(() {
        userName = userDoc['name'];
        profilePic = userDoc['profile_pic'];
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  final storageRef = FirebaseStorage.instance.ref().child('Profile_Pic');

  final picker = ImagePicker();

  Future<void> pickImageAndUpload() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // Handle no internet connection
        print('No internet connection');
        return;
      }

      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        try {
          UploadTask uploadTask = storageRef
              .child('$currentUserUid/$currentUserUid')
              .putFile(File(pickedFile.path));
          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
          String imageUrl = await taskSnapshot.ref.getDownloadURL();

          setState(() {});
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserUid)
              .update({
            'profile_pic': imageUrl,
          });
          getUserData();
        } catch (e) {
          print('Error uploading image: $e');
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

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
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: SizedBox(
                      height: 110,
                      width: 110,
                      child: CircleAvatar(
                        backgroundColor: tPrimaryActionColor,
                        child: CircleAvatar(
                          radius: 54,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.network(
                              profilePic,
                              width: 108,
                              height: 108,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Image.asset(
                                  'assets/images/icons/default_profile.jpg',
                                  width: 108,
                                  height: 108,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
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
                          child: GestureDetector(
                            onTap: () {
                              pickImageAndUpload();
                            },
                            child: const Icon(
                              Icons.mode_edit_rounded,
                              color: tPrimaryActionColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 145),
                    child: Text(
                      userName.isEmpty
                          ? "Mashtaly user"
                          : userName.toCapitalized(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
                      try {
                        AppSettings.openAppSettings(
                          type: AppSettingsType.notification,
                        );
                      } catch (e) {
                        print('Error opening app settings: $e');
                      }
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
                    onTap: () {
                      try {
                        // Your settings code goes here
                      } catch (e) {
                        print('Error in settings: $e');
                      }
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
                    onTap: () {
                      try {
                        // Your help code goes here
                      } catch (e) {
                        print('Error in help: $e');
                      }
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
                      try {
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
                                actionsAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => const Auth(),
                                          ),
                                          (Route<dynamic> route) => false,
                                        );
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
                      } catch (e) {
                        print('Error in logout: $e');
                      }
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
