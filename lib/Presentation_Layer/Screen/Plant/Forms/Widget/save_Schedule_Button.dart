import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashtaly_app/Presentation_Layer/Widget/snakBar.dart';

import '../../../../../Business_Layer/cubits/plant/plantCubit.dart';
import '../../../../../Constants/colors.dart';
import 'delayed_Watering_Column.dart';
import 'schedule_Widget.dart';
import 'weather_Condition_Column.dart';

class SaveScheduleButton extends StatefulWidget {
  final dynamic currentUserUid,
      image,
      plantNameController,
      amountOfWaterController,
      fromDateController,
      untilDateController;

  const SaveScheduleButton(
      {super.key,
      this.currentUserUid,
      this.image,
      this.plantNameController,
      this.amountOfWaterController,
      this.fromDateController,
      this.untilDateController});
  @override
  _SaveScheduleButtonState createState() => _SaveScheduleButtonState();
}

int random5digit = generateUniqueRandom5DigitsNumber();
int generateUniqueRandom5DigitsNumber() {
  DateTime now = DateTime.now().toUtc();
  int year = now.year;
  int month = now.month;
  int day = now.day;
  int hour = now.hour;
  int minute = now.minute;
  int second = now.second;

  int seed = year * 100000000 +
      month * 1000000 +
      day * 10000 +
      hour * 100 +
      minute * 10 +
      second;

  Random random = Random(seed);
  int uniqueRandomNumber = random.nextInt(90000) + 10000;

  return uniqueRandomNumber;
}

class _SaveScheduleButtonState extends State<SaveScheduleButton> {
  List<List<dynamic>> weatherConditionAndDuration = [];

  List<List<dynamic>> combineWeatherAndDuration() {
    List<List<dynamic>> combinedList = [];
    for (int i = 0; i < duration.length; i++) {
      if (i < weatherCondition.length) {
        combinedList.add([
          weatherCondition[i],
          duration[i][0], // days
          duration[i][1], // hours
        ]);
      }
    }
    return combinedList;
  }

  bool isLoading = false;

  Widget buildSaveScheduleButton(
    BuildContext context,
    image,
    currentUserUid,
    plantNameController,
    amountOfWaterController,
    fromDateController,
    untilDateController,
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

            var plantCubit = BlocProvider.of<PlantCubit>(context);
            plantCubit.addPlant(
              imageFile: image,
              plantName: plantNameController?.text?.trim(),
            );
            uploadImage(
              currentUserUid,
              image,
            );

            setState(() {
              isLoading = true;
            });

            await addMyPlantToFirestore(
              context,
              plantNameController,
              amountOfWaterController,
              fromDateController,
              untilDateController,
              timeInEachWeekAndDay, // Assuming you have this variable defined
            );

            setState(() {
              isLoading = false;
            });

            Navigator.of(context).pop();
          } catch (e) {
            print('Error adding plant: $e');
            showSnakBar(context, 'Error adding plant: $e');
            setState(() {
              isLoading = false;
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
    );
  }

  Future<String> uploadImage(
    currentUserUid,
    image,
  ) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        print('No internet connection');
      }

      if (image != null) {
        try {
          String imagePath =
              'MyPlant_Pic/$currentUserUid/MyPlant$random5digit/myplant_image_1';
          UploadTask uploadTask =
              storageRef.child(imagePath).putFile(File(image.path));
          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
          String imageUrl = await taskSnapshot.ref.getDownloadURL();
          return imageUrl;
        } catch (e) {
          print('Error add photo to storage: $e');
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return 'Error';
  }

  Future<void> addMyPlantToFirestore(
    BuildContext context,
    plantNameController,
    amountOfWaterController,
    fromDateController,
    untilDateController,
    List<dynamic> timeInEachWeekAndDay,
  ) async {
    try {
      final currentUser = auth.currentUser;

      if (currentUser == null) {
        print('Error: No currently signed-in user');
        return;
      }
      weatherConditionAndDuration = combineWeatherAndDuration();

      String imageUrl = await uploadImage(currentUser, widget.image);
      await firestore.collection('myPlants').doc(currentUser.uid).set({
        "lastUpdate": DateTime.now().toUtc().toString(),
        "user_id": currentUser.uid,
      });

      final plantData = {
        "id": '${generateUniqueRandom5DigitsNumber()}',
        "myPlant_pic1": imageUrl,
        "plantName": plantNameController.text.trim(),
        "amountOfWater": amountOfWaterController?.text?.trim(),
        "from": fromDateController?.text?.trim(),
        "until": untilDateController?.text?.trim(),
        "active": true,
        "date": '${DateTime.now()}',
        "user_id": currentUser.uid,
      };

      // Check if weatherConditionAndDuration is not empty
      if (weatherConditionAndDuration.isNotEmpty) {
        plantData["weatherConditionsAndDurations"] = weatherConditionAndDuration
            .map((item) => {
                  "weatherCondition": item[0],
                  "delayDay": item[1],
                  "delayHour": item[2],
                })
            .toList();
      }

      // Check if timeInEachWeekAndDay is not empty
      if (timeInEachWeekAndDay.isNotEmpty) {
        plantData["schedule"] = timeInEachWeekAndDay
            .map((item) => {
                  "week": item[0],
                  "day": item[1],
                  "time": item[2],
                })
            .toList();
      }

      await firestore
          .collection('myPlants')
          .doc(currentUser.uid)
          .collection('MyPlants')
          .add(plantData);

      Navigator.pop(context);
    } catch (e) {
      print('Error adding plant: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildSaveScheduleButton(
      context,
      widget.image,
      widget.currentUserUid,
      widget.plantNameController,
      widget.amountOfWaterController,
      widget.fromDateController,
      widget.untilDateController,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    weatherCondition.clear();
    duration.clear();
    timeInEachWeekAndDay.clear();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref().child('MyPlant_Pic');
