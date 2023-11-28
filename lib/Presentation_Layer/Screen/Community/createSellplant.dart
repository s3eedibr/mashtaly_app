import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Constants/colors.dart';
import '../../Widget/sankBar.dart';

class CreateSellPlant extends StatefulWidget {
  const CreateSellPlant({
    super.key,
  });

  @override
  State<CreateSellPlant> createState() => _CreateSellPlantState();
}

class _CreateSellPlantState extends State<CreateSellPlant> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final List<XFile> _selectedImages = [];
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<List<String>> uploadImages(List<XFile> selectedImages) async {
    List<String> imageUrls = [];
    final random5digit = generateUniqueRandom5DigitsNumber();
    for (int i = 0; i < selectedImages.length; i++) {
      var image = selectedImages[i];
      try {
        final currentUser = _auth.currentUser;

        if (currentUser == null) {
          print('Error: No currently signed-in user');
          return [];
        }

        String imagePath =
            'Sell_Pic/${currentUser.uid}/Sell$random5digit/sell_image_${i + 1}';
        UploadTask uploadTask =
            _storage.ref().child(imagePath).putFile(File(image.path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        imageUrls.add(imageUrl);
      } catch (e) {
        print('Error uploading image $i: $e');
      }
    }

    return imageUrls;
  }

  int generateUniqueRandom5DigitsNumber() {
    // Get the current DateTime
    DateTime now = DateTime.now().toUtc();

    // Extract individual components (year, month, day, hour, minute, second)
    int year = now.year;
    int month = now.month;
    int day = now.day;
    int hour = now.hour;
    int minute = now.minute;
    int second = now.second;

    // Combine the components to create a unique seed for the random number generator
    int seed = year * 100000000 +
        month * 1000000 +
        day * 10000 +
        hour * 100 +
        minute * 10 +
        second;

    // Use the seed to generate a random number between 10000 and 99999
    Random random = Random(seed);
    int uniqueRandomNumber = random.nextInt(90000) + 10000;

    return uniqueRandomNumber;
  }

  Future<void> addPostToFirestore(List<String> imageUrls) async {
    try {
      final currentUser = _auth.currentUser;

      if (currentUser == null) {
        print('Error: No currently signed-in user');
        return;
      }
      await _firestore
          .collection('sellPlants')
          .doc(currentUser.uid)
          .collection('SellPlants')
          .add({
        "id": '${generateUniqueRandom5DigitsNumber()}',
        "title": _titleController.text.trim(),
        "content": _contentController.text.trim(),
        "sell_pic1": imageUrls.isNotEmpty ? imageUrls[0] : null,
        "sell_pic2": imageUrls.length > 1 ? imageUrls[1] : null,
        "sell_pic3": imageUrls.length > 2 ? imageUrls[2] : null,
        "sell_pic4": imageUrls.length > 3 ? imageUrls[3] : null,
        "sell_pic5": imageUrls.length > 4 ? imageUrls[4] : null,
        "posted": false,
        "date": '${DateTime.now().toUtc()}',
        "user": (await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .get())
            .get('name'),
        "user_id": currentUser.uid,
        "profile_pic": (await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .get())
            .get('profile_pic'),
      });

      showSnakBar(context, 'Post submitted! Admin review in progress.',
          color: tPrimaryActionColor);
      Navigator.pop(context);
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  Future<void> uploadImagesAndAddPost() async {
    try {
      bool isConnected = await checkConnectivity();

      if (!isConnected) {
        print('No internet connection.');
        showSnakBar(context, 'No internet connection.');
        return;
      }
      if (_selectedImages.length < 3) {
        print('Error: Please choose at least 3 pictures.');
        showSnakBar(context, 'Please choose at least 3 pictures.');
        return;
      }
      if (_titleController.text.isEmpty) {
        print('Error: Please enter title for sell.');
        showSnakBar(context, 'Please enter title for sell.');
        return;
      }

      if (_contentController.text.isEmpty) {
        print('Error: Please enter content for sell.');
        showSnakBar(context, 'Please enter content for sell.');
        return;
      }

      List<String> imageUrls = await uploadImages(_selectedImages);

      await addPostToFirestore(imageUrls);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Set isLoading to false in case of an error
      setState(() {
        isLoading = false;
      });

      print('Error uploading images and adding post: $e');
    }
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
      source: source,
      imageQuality: 25,
    );
    if (file != null) {
      setState(() {
        _selectedImages.add(file);
      });
    } else {
      print("no image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
        title: const Text(
          "Create a Sell",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectImageDialog(context);
                    },
                    child: Container(
                      height: 200,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: _selectedImages.isNotEmpty
                          ? Image.file(
                              File(_selectedImages[0].path),
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              FontAwesomeIcons.plus,
                              color: tSearchIconColor,
                              size: 55,
                            ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    selectImageDialog(context);
                  },
                  child: Container(
                    height: 95,
                    width: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: _selectedImages.length > 1
                        ? Image.file(
                            File(_selectedImages[1].path),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            FontAwesomeIcons.plus,
                            color: tSearchIconColor,
                            size: 25,
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectImageDialog(context);
                  },
                  child: Container(
                    height: 95,
                    width: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: _selectedImages.length > 2
                        ? Image.file(
                            File(_selectedImages[2].path),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            FontAwesomeIcons.plus,
                            color: tSearchIconColor,
                            size: 25,
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectImageDialog(context);
                  },
                  child: Container(
                    height: 95,
                    width: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: _selectedImages.length > 3
                        ? Image.file(
                            File(_selectedImages[3].path),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            FontAwesomeIcons.plus,
                            color: tSearchIconColor,
                            size: 25,
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectImageDialog(context);
                  },
                  child: Container(
                    height: 95,
                    width: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: _selectedImages.length > 4
                        ? Image.file(
                            File(_selectedImages[4].path),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            FontAwesomeIcons.plus,
                            color: tSearchIconColor,
                            size: 25,
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            CustomField(
              titleField: 'Title',
              heightField: 65,
              maxLine: 1,
              maxLength: 20,
              controller: _titleController,
            ),
            CustomField(
              titleField: 'Content',
              heightField: 180,
              maxLine: 50,
              maxLength: 2000,
              controller: _contentController,
            ),
            const SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 380,
        child: FloatingActionButton(
          backgroundColor: tPrimaryActionColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          onPressed: () {
            // Check if the operation is already in progress
            if (!isLoading) {
              // Set isLoading to true to show the loading indicator
              setState(() {
                isLoading = true;
              });

              // Call the function that performs the upload and adds the post
              uploadImagesAndAddPost().then((_) {
                // Set isLoading to false when the operation is complete
                setState(() {
                  isLoading = false;
                });
              });
            }
          },
          child: Center(
            child: isLoading
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        'Please wait...',
                        style: TextStyle(
                          color: tThirdTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  )
                : const Text(
                    "Publish",
                    style: TextStyle(
                      color: tThirdTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> selectImageDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Select Image from"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      await pickImage(ImageSource.camera);
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.camera_alt_rounded),
                        Text("Camera"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      await pickImage(ImageSource.gallery);
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.image),
                        Text("Gallery"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.titleField,
    required this.heightField,
    required this.maxLine,
    required this.maxLength,
    required this.controller,
  }) : super(key: key);

  final String titleField;
  final double heightField;
  final int maxLine;
  final int maxLength;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          titleField,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0x7C0D1904),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: heightField,
          width: 375,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "This field is required";
              } else {
                return null;
              }
            },
            maxLines: maxLine,
            maxLength: maxLength,
            cursorColor: tPrimaryActionColor,
            controller: controller,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 15,
              ),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
