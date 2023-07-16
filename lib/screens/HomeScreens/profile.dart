import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mashtaly_app/Auth/auth.dart';

import '../../Constants/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  Future<void> pickImage() async {
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<String> uploadImageToFirebase() async {
    if (_selectedImage == null) {
      return 'assets/images/icons/default_profile.jpg';
    }

    // Create a unique filename for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Reference to Firebase Storage
    Reference storageReference =
        FirebaseStorage.instance.ref().child('Profile_images/$fileName');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(_selectedImage!);

    // Await the upload completion and get the download URL
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Return the download URL
    return downloadUrl;
  }

  void _handleUploadButton() async {
    await pickImage();
    String downloadUrl = await uploadImageToFirebase();
    print('Download URL: $downloadUrl');
  }

  Future<String?> fetchProfilePictureUrl(String userId) async {
    try {
      // Reference to the profile picture in Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child('Profile_images/$userId.jpg');

      // Get the download URL of the profile picture
      String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error fetching profile picture URL: $e');
      return null;
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
              child: GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        height: 110,
                        width: 110,
                        child: CircleAvatar(
                          backgroundColor: tPrimaryActionColor,
                          child: CircleAvatar(
                            radius: 54,
                            backgroundImage: _selectedImage != null
                                ? FileImage(File(_selectedImage!.path))
                                    as ImageProvider<Object>
                                : AssetImage(
                                    'assets/images/icons/default_profile.jpg'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 230,
                      top: 95,
                      child: Container(
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
                      padding: const EdgeInsets.only(top: 145),
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
            SizedBox(
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
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            'assets/images/icons/Group 268.png',
                            height: 38,
                            width: 38,
                          ),
                          SizedBox(
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
                    onTap: () {},
                  ),
                  SizedBox(
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
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            'assets/images/icons/Group 269.png',
                            height: 38,
                            width: 38,
                          ),
                          SizedBox(
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
                  SizedBox(
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
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            'assets/images/icons/Group 270.png',
                            height: 38,
                            width: 38,
                          ),
                          SizedBox(
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
                  SizedBox(
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
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            'assets/images/icons/Group 271.png',
                            height: 38,
                            width: 38,
                          ),
                          SizedBox(
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
                              'Are You Sure to Logout?',
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
                                          builder: (context) => Auth(),
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
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
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
