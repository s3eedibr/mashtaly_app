import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Function to check device connectivity
Future<ConnectivityResult> checkConnectivity() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult;
}

Future<List<Map<String, dynamic>>> getAllData(String collectionName) async {
  List<Map<String, dynamic>> allData = [];

  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot = await userUidsRef.get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userId)
          .collection(collectionName == 'posts' ? 'Posts' : 'SalePlants');

      try {
        // Get a snapshot of data for the current user, ordered by date in descending order
        QuerySnapshot userDataSnapshot = await userPostsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .get();

        // Iterate through each data document and add data to the list
        for (final dataDoc in userDataSnapshot.docs) {
          final data = dataDoc.data() as Map<String, dynamic>;
          allData.add(data);
        }
      } catch (e) {
        // Handle errors when getting data for a user
        print('Error getting data for user $userId: $e');
      }
    }
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
  }

  // Sort the list in descending order by date
  allData.sort((a, b) => b['date'].compareTo(a['date']));

  return allData;
}

// Example usage for getting all posts
Future<List<Map<String, dynamic>>> getAllPosts() async {
  return await getAllData('posts');
}

// Example usage for getting all sale posts
Future<List<Map<String, dynamic>>> getAllSalesPosts() async {
  return await getAllData('salePlants');
}

// Example usage for getting the latest posts (limited to 3)
Future<List<Map<String, dynamic>>> getLatestPosts() async {
  List<Map<String, dynamic>> latestPosts = await getAllData('posts');
  return latestPosts.take(3).toList();
}

// Example usage for getting the latest sale posts (limited to 3)
Future<List<Map<String, dynamic>>> getLatestSalePosts() async {
  List<Map<String, dynamic>> latestSalePosts = await getAllData('salePlants');
  return latestSalePosts.take(3).toList();
}

Future<List<Map<String, dynamic>>> getMyData(
    {required String collectionName, required String userId}) async {
  List<Map<String, dynamic>> myData = [];

  final userPlantsRef = FirebaseFirestore.instance
      .collection(collectionName)
      .doc(userId)
      .collection(collectionName == 'myPlants' ? 'MyPlants' : '');

  try {
    // Get a snapshot of data for the current user, ordered by date in descending order
    QuerySnapshot userPlantsSnapshot =
        await userPlantsRef.orderBy('date', descending: true).get();

    // Iterate through each data document and add data to the list
    for (final dataDoc in userPlantsSnapshot.docs) {
      final data = dataDoc.data() as Map<String, dynamic>;
      myData.add(data);
    }
  } catch (e) {
    // Handle errors when getting data for the user
    print('Error getting data for user $userId: $e');
    rethrow; // Rethrow the exception to let the caller handle it
  }

  // Sort the list in descending order by date
  myData.sort((a, b) => b['date'].compareTo(a['date']));

  return myData;
}

// Example usage for getting posts for the current user
Future<List<Map<String, dynamic>>> getMyPlants(String userId) async {
  return await getMyData(collectionName: 'myPlants', userId: userId);
}

Future<void> updateActiveFlagForMyPlant({
  required String collectionName,
  required String userId,
  required String myId,
  required bool isActive,
}) async {
  final userPlantsRef = FirebaseFirestore.instance
      .collection(collectionName)
      .doc(userId)
      .collection(collectionName == 'myPlants' ? 'MyPlants' : '');

  try {
    // Get a reference to the document with the specified myId
    final QuerySnapshot myPlantDocSnapshot =
        await userPlantsRef.where('id', isEqualTo: myId).get();

    // Check if the document exists
    if (myPlantDocSnapshot.docs.isNotEmpty) {
      // Update the 'active' field in the document
      final DocumentReference myPlantDocRef =
          userPlantsRef.doc(myPlantDocSnapshot.docs.first.id);
      await myPlantDocRef.update({'active': isActive});
    } else {
      // Handle the case where the document with the specified myId does not exist
      print(
          'Document with ID $myId does not exist in $collectionName collection.');
    }
  } catch (e) {
    // Handle errors when updating the active flag
    print('Error updating active flag for myId $myId: $e');
    rethrow; // Rethrow the exception to let the caller handle it
  }
}

Future<List<List<dynamic>>> fetchWeatherConditionAndDuration({
  required String myId,
  required String userId,
}) async {
  List<List<dynamic>> weatherConditionAndDuration = [];
  CollectionReference myPlantsCollection = FirebaseFirestore.instance
      .collection('myPlants')
      .doc(userId)
      .collection('MyPlants');

  try {
    QuerySnapshot querySnapshot =
        await myPlantsCollection.where('id', isEqualTo: myId).get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      // Assuming 'weatherConditionsAndDurations' is an array field in your document
      List<dynamic> weatherConditionsAndDurations =
          data['weatherConditionsAndDurations'] ?? [];

      for (var weatherCondition in weatherConditionsAndDurations) {
        weatherConditionAndDuration.add([
          weatherCondition['weatherCondition'],
          weatherCondition['delayDay'],
          weatherCondition['delayHour'],
          weatherCondition['delayMinute'],
        ]);
      }
    }
    return weatherConditionAndDuration;
  } catch (e) {
    // Handle errors when fetching data from Firebase
    print('Error fetching weather data: $e');
    throw e;
  }
}

Future<List<List<dynamic>>> fetchTimeInEachWeekAndDay({
  required String myId,
  required String userId,
}) async {
  List<List<dynamic>> saveTimeInEachWeekAndDay = [];
  CollectionReference myPlantsCollection = FirebaseFirestore.instance
      .collection('myPlants')
      .doc(userId)
      .collection('MyPlants');

  try {
    QuerySnapshot querySnapshot =
        await myPlantsCollection.where('id', isEqualTo: myId).get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      // Assuming 'schedule' is an array field in your document
      List<dynamic> timeInEachWeekAndDay = data['schedule'] ?? [];

      if (timeInEachWeekAndDay.isNotEmpty) {
        // Convert 'schedule' data to the desired format
        saveTimeInEachWeekAndDay = timeInEachWeekAndDay
            .map((item) => [
                  item['week'],
                  item['day'],
                  item['time'],
                ])
            .toList();
      }
    }
    return saveTimeInEachWeekAndDay;
  } catch (e) {
    // Handle errors when fetching data from Firebase
    print('Error fetching weather data: $e');
    throw e;
  }
}
