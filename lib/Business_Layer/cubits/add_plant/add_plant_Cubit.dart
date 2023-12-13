import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Presentation_Layer/Screen/Plant/Data/getData.dart';
import '../../../Presentation_Layer/Screen/Plant/Forms/Widget/delayed_Watering_Column.dart';
import '../../../Presentation_Layer/Screen/Plant/Forms/Widget/schedule_Widget.dart';
import '../../../Presentation_Layer/Screen/Plant/Forms/Widget/weather_Condition_Column.dart';
import 'add_plant_States.dart';

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

int random5digit = generateUniqueRandom5DigitsNumber();

class AddPlantCubit extends Cubit<AddPlantState> {
  AddPlantCubit() : super(PlantInitialState());

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref().child('MyPlant_Pic');

  List<List<dynamic>> weatherConditionAndDuration = [];
  List<List<dynamic>> combineWeatherAndDuration() {
    List<List<dynamic>> combinedList = [];
    for (int i = 0; i < duration.length; i++) {
      if (i < weatherCondition.length) {
        combinedList.add([
          weatherCondition[i],
          duration[i][0], // days
          duration[i][1], // hours
          duration[i][2], // minutes
        ]);
      }
    }
    return combinedList;
  }

  Future<String> uploadImage(currentUserUid, image) async {
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
          print('Error adding photo to storage: $e');
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return 'Error';
  }

  Future<void> addMyPlantToFirestore(
      image,
      currentUserUid,
      plantNameController,
      amountOfWaterController,
      fromDateController,
      untilDateController,
      withSensor) async {
    try {
      final currentUser = auth.currentUser;

      if (currentUser == null) {
        print('Error: No currently signed-in user');
        return;
      }
      weatherConditionAndDuration = combineWeatherAndDuration();

      String imageUrl = await uploadImage(currentUser.uid, image);
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
        "sensor": withSensor,
      };

      if (weatherConditionAndDuration.isNotEmpty) {
        plantData["weatherConditionsAndDurations"] = weatherConditionAndDuration
            .map((item) => {
                  "weatherCondition": item[0],
                  "delayDay": item[1],
                  "delayHour": item[2],
                  "delayMinute": item[3],
                })
            .toList();
      }

      if (timeInEachWeekAndDay.isNotEmpty) {
        plantData["schedule"] = timeInEachWeekAndDay
            .map((item) => {
                  "week": item[0],
                  "day": item[1],
                  "time": item[2],
                })
            .toList();
      }
      print(timeInEachWeekAndDay);
      await firestore
          .collection('myPlants')
          .doc(currentUser.uid)
          .collection('MyPlants')
          .add(plantData);
    } catch (e) {
      print('Error adding plant: $e');
    }
  }

  Future<void> loadData(String userId) async {
    try {
      emit(PlantLoadingState());

      // Fetch data from Firestore using the getMyPlants function
      final myData = await getMyPlants(userId);
      emit(PlantLoadingState());
      if (myData.isEmpty) {
        emit(PlantNoDataState());
      } else {
        emit(UpdatePlantScreen(myData: myData));
      }
    } catch (e) {
      print('Error loading data: $e');
      emit(PlantNoDataState());
    }
  }

  Future<void> addPlant(
    image,
    currentUserUid,
    plantNameController,
    amountOfWaterController,
    fromDateController,
    untilDateController,
    withSensor,
  ) async {
    try {
      emit(PlantLoadingState());
      await addMyPlantToFirestore(
        image,
        currentUserUid,
        plantNameController,
        amountOfWaterController,
        fromDateController,
        untilDateController,
        withSensor,
      );
      await Future.delayed(const Duration(seconds: 7));

      if (image != null) {
        emit(PlantSuccessDataState(
          image,
          currentUserUid,
          plantNameController,
          amountOfWaterController,
          fromDateController,
          untilDateController,
          withSensor,
        ));
        emit(PlantLoadingState());
        final myData =
            await getMyPlants(FirebaseAuth.instance.currentUser!.uid);
        emit(PlantLoadingState());
        emit(UpdatePlantScreen(myData: myData));
        weatherCondition.clear();
        duration.clear();
        timeInEachWeekAndDay.clear();
      } else {
        emit(PlantNoDataState());
      }
    } catch (e) {
      emit(PlantErrorState(e.toString()));
    }
  }
}
