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
    String collectionName, String userId) async {
  List<Map<String, dynamic>> myData = [];

  final userPostsRef = FirebaseFirestore.instance
      .collection(collectionName)
      .doc(userId)
      .collection(collectionName == 'posts' ? 'Posts' : 'SalePlants');

  try {
    // Get a snapshot of data for the current user, ordered by date in descending order
    QuerySnapshot userPostsSnapshot = await userPostsRef
        .where('posted', isEqualTo: true)
        .orderBy('date', descending: true)
        .get();

    // Iterate through each data document and add data to the list
    for (final dataDoc in userPostsSnapshot.docs) {
      final data = dataDoc.data() as Map<String, dynamic>;
      myData.add(data);
    }
  } catch (e) {
    // Handle errors when getting data for the user
    print('Error getting data for user $userId: $e');
  }

  // Sort the list in descending order by date
  myData.sort((a, b) => b['date'].compareTo(a['date']));

  return myData;
}

// Example usage for getting posts for the current user
Future<List<Map<String, dynamic>>> getMyPosts(String userId) async {
  return await getMyData('posts', userId);
}

// Example usage for getting sale posts for the current user
Future<List<Map<String, dynamic>>> getMySales(String userId) async {
  return await getMyData('salePlants', userId);
}
