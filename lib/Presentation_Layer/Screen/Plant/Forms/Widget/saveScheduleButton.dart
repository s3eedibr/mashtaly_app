import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Business_Layer/cubits/plant/plantCubit.dart';
import '../../../../../Constants/colors.dart';
import '../../../../Widget/snakBar.dart';

final random5digit = generateUniqueRandom5DigitsNumber();
// Function to generate a unique random 5-digit number
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

Widget buildSaveScheduleButton(
  BuildContext context,
  currentUserUid,
  image,
  plantNameController,
  amountOfWaterController,
  fromDateController,
  untilDateController,
  day,
  hour,
  selectedWeatherText,
) {
  return SizedBox(
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
      onPressed: () async {
        try {
          if (image == null) {
            print('Error: Please select an image.');
            showSnakBar(context, 'Please select an image.');
            return;
          }

          if (plantNameController.text.isEmpty) {
            print('Error: Please enter plant name.');
            showSnakBar(context, 'Please enter plant name.');
            return;
          }
          if (amountOfWaterController.text.isEmpty) {
            print('Error: Please enter Amount of water per watering.');
            showSnakBar(context, 'Please enter amount of water per watering.');
            return;
          }

          var plantCubit = BlocProvider.of<PlantCubit>(context);
          plantCubit.addPlant(
            imageFile: image,
            plantName: plantNameController.text.trim(),
            amountOfWater:
                double.tryParse(amountOfWaterController.text.trim()) ?? 0.0,
          );
          Navigator.of(context).pop();
        } catch (e) {
          print('Error adding plant: $e');
          showSnakBar(context, 'Error adding plant: $e');
        }
        uploadToFireStorage(
          currentUserUid,
          image,
        );
        addMyPlantToFirestore(
          context,
          image,
          plantNameController,
          amountOfWaterController,
          fromDateController,
          untilDateController,
          day,
          hour,
          selectedWeatherText,
        );
      },
      child: const Center(
        child: Text(
          "Save Schedule",
          style: TextStyle(
            color: tThirdTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}

final storageRef = FirebaseStorage.instance.ref().child('MyPlant_Pic');
Future<void> uploadToFireStorage(
  currentUserUid,
  image,
) async {
  try {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print('No internet connection');
      return;
    }

    if (image != null) {
      try {
        String imagePath =
            'MyPlant_Pic/$currentUserUid/MyPlant$random5digit/myplant_image_1';
        UploadTask uploadTask = storageRef.child(imagePath).putFile(image!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        print(imageUrl);
      } catch (e) {
        print('Error updating profile_pic in collections: $e');
      }
    }
  } catch (e) {
    print('Error picking image: $e');
  }
}

// Firebase instances
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Function to add post data to Firestore
Future<void> addMyPlantToFirestore(
  BuildContext context,
  String imageUrl,
  plantNameController,
  amountOfWaterController,
  fromDateController,
  untilDateController,
  day,
  hour,
  selectedWeatherText,
) async {
  try {
    final currentUser = auth.currentUser;

    if (currentUser == null) {
      print('Error: No currently signed-in user');
      return;
    }
    await firestore.collection('posts').doc(currentUser.uid).set({
      "lastUpdate": DateTime.now().toUtc().toString(),
      "user_id": currentUser.uid,
    });

    await firestore
        .collection('myPlants')
        .doc(currentUser.uid)
        .collection('MyPlants')
        .add({
      "id": '${generateUniqueRandom5DigitsNumber()}',
      "myPlant_pic1": imageUrl.isNotEmpty ? imageUrl : null,
      "plantName": plantNameController.text.trim(),
      "amountOfWater": amountOfWaterController.text.trim(),
      "from":
          fromDateController != null ? fromDateController.text.trim() : null,
      "until":
          untilDateController != null ? untilDateController.text.trim() : null,
      "delayDay": day,
      "delayHour": hour,
      "if": selectedWeatherText,
      "active": true,
      "date": '${DateTime.now()}',
      "user_id": currentUser.uid,
    });

    showSnakBar(context, 'Post submitted! Admin review in progress.',
        color: tPrimaryActionColor);
    Navigator.pop(context);
  } catch (e) {
    print('Error adding post: $e');
  }
}
