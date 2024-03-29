import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Constants/colors.dart';
import '../../Widget/snackBar.dart';
import 'myPosts.dart';
import 'mySales.dart';

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
        showSnackBar(context, 'No internet connection');
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

          // Update profile_pic in 'users'
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserUid)
              .update({
            'profile_pic': imageUrl,
          });

          // Update profile_pic in 'posts'
          await FirebaseFirestore.instance
              .collection('posts')
              .doc(currentUserUid)
              .collection('Posts')
              .where('user_id', isEqualTo: currentUserUid)
              .get()
              .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              doc.reference.update({'profile_pic': imageUrl});
            }
          });

          // Update profile_pic in 'salePlants'
          await FirebaseFirestore.instance
              .collection('salePlants')
              .doc(currentUserUid)
              .collection('SalePlants')
              .where('user_id', isEqualTo: currentUserUid)
              .get()
              .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              doc.reference.update({'profile_pic': imageUrl});
            }
          });

          setState(() {});
          getUserData();
        } catch (e) {
          print('Error updating profile_pic in collections: $e');
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getUserData();
    });
    return Scaffold(
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
            height: 250,
            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: SizedBox(
                    height: 110,
                    width: 110,
                    child: CircleAvatar(
                      backgroundColor: tPrimaryActionColor,
                      child: CircleAvatar(
                        radius: 54,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: profilePic.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: profilePic,
                                  width: 108,
                                  height: 108,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (BuildContext context, String url) =>
                                          const Center(
                                              child: CircularProgressIndicator(
                                    color: tPrimaryActionColor,
                                  )),
                                  errorWidget: (BuildContext context,
                                          String url, dynamic error) =>
                                      Image.asset(
                                    'assets/images/icons/default_profile.jpg',
                                    width: 108,
                                    height: 108,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 108,
                                    width: 108,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 230,
                  top: 145,
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
                  padding: const EdgeInsets.only(top: 195),
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
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
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
                              'assets/images/icons/Group 185.png',
                              height: 38,
                              width: 38,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text(
                              'My article',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ListMyPosts(),
                          ),
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
                              'assets/images/icons/Group 192.png',
                              height: 38,
                              width: 38,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text(
                              'My plant for sale',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ListMySales(),
                          ),
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
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const SettingScreen(),
                          //   ),
                          // );
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
                                data: Theme.of(context).copyWith(
                                  canvasColor: Colors.white,
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
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pop(context);
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
