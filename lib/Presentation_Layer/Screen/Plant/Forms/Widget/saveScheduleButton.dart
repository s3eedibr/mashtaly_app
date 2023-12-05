import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Business_Layer/cubits/plant/plantCubit.dart';
import '../../../../../Constants/colors.dart';
import '../../../../Widget/snakBar.dart';

Widget buildSaveScheduleButton(BuildContext context, currentUserUid, image,
    plantNameController, amountOfWaterController) {
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
        uploadToFireStorage(currentUserUid, image);
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
Future<void> uploadToFireStorage(currentUserUid, image) async {
  try {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print('No internet connection');
      return;
    }

    if (image != null) {
      try {
        UploadTask uploadTask =
            storageRef.child('$currentUserUid/$currentUserUid').putFile(image!);
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
