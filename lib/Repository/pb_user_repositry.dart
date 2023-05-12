// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../Constants/colors.dart';

// class PBUserRepository extends GetxController {
//   static PBUserRepository get Instance => Get.find();

//   final _db = FirebaseFirestore.instance;
//   createPBUser(UserModel user) async {
//     await _db
//         .collection("PlantBreeder")
//         .add(user.toJson())
//         .whenComplete(
//           () => Get.snackbar("Success", "You Account Has Been Created.",
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: tPrimaryTextColor.withOpacity(0.1),
//               colorText: tPrimaryActionColor),
//         )
//         .catchError((error, stackTrace) {
//       Get.snackbar("Error", "Something Went Wrong. Try Again",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: tPrimaryTextColor.withOpacity(0.1),
//           colorText: tThirdTextErrorColor);
//       print(error.toString());
//     });
//   }
// }
