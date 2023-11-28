import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Function to check device connectivity
Future<ConnectivityResult> checkConnectivity() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult;
}

// Simulated loading delay function
Future<bool> isLoading() async {
  await Future.delayed(const Duration(milliseconds: 2500));
  return true;
}

// Function to get all posts from all users
Future<List<Map<String, dynamic>>> getAllPosts() async {
  List<Map<String, dynamic>> allPosts = [];
  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot = await userUidsRef.get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('Posts');

      try {
        // Get a snapshot of posts for the current user, ordered by date in descending order
        QuerySnapshot userPostsSnapshot = await userPostsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .get();

        // Iterate through each post document
        for (final postDoc in userPostsSnapshot.docs) {
          final postData = postDoc.data() as Map<String, dynamic>;
          // Add the post data to the list
          allPosts.add(postData);
          print('User $userId Post:');
        }
      } catch (e) {
        // Handle errors when getting posts for a user
        print('Error getting posts for user $userId: $e');
      }
    }

    return allPosts;
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
    return [];
  }
}

// Function to get the latest posts (limited to 3) from all users
Future<List<Map<String, dynamic>>> getLatestPosts() async {
  List<Map<String, dynamic>> latestPosts = [];
  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot = await userUidsRef.get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('Posts');

      try {
        // Get a snapshot of the latest 3 posts for the current user, ordered by date in descending order
        QuerySnapshot userPostsSnapshot = await userPostsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .limit(3)
            .get();

        // Iterate through each post document
        for (final postDoc in userPostsSnapshot.docs) {
          final postData = postDoc.data() as Map<String, dynamic>;
          // Add the post data to the list
          latestPosts.add(postData);
          // Process each post data as needed
          print('User $userId Post:');
        }
      } catch (e) {
        // Handle errors when getting posts for a user
        print('Error getting posts for user $userId: $e');
      }
    }

    return latestPosts;
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
    return [];
  }
}

// Function to get all posts from all users without additional processing
Future<List<Map<String, dynamic>>> getAllPostsList() async {
  List<Map<String, dynamic>> allPosts = [];

  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot = await userUidsRef.get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('Posts');

      try {
        // Get a snapshot of posts for the current user, ordered by date in descending order
        QuerySnapshot userPostsSnapshot = await userPostsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .get();

        // Iterate through each post document and add data to the list
        for (final postDoc in userPostsSnapshot.docs) {
          final postData = postDoc.data() as Map<String, dynamic>;
          allPosts.add(postData);
        }
      } catch (e) {
        // Handle errors when getting posts for a user
        print('Error getting posts for user $userId: $e');
      }
    }
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
  }

  return allPosts;
}

// Function to get all sell posts from all users
Future<List<Map<String, dynamic>>> getAllSellPosts() async {
  List<Map<String, dynamic>> allSellPosts = [];
  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot = await userUidsRef.get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userSellsRef = FirebaseFirestore.instance
          .collection('sellPlants')
          .doc(userId)
          .collection('SellPlants');

      try {
        // Get a snapshot of sell posts for the current user, ordered by date in descending order
        QuerySnapshot userSellsSnapshot = await userSellsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .get();

        // Iterate through each sell post document
        for (final sellDoc in userSellsSnapshot.docs) {
          final sellData = sellDoc.data() as Map<String, dynamic>;
          // Add the sell data to the list
          allSellPosts.add(sellData);
          // Process each sell data as needed
          print('User $userId Sell:');
        }
      } catch (e) {
        // Handle errors when getting sells for a user
        print('Error getting sells for user $userId: $e');
      }
    }
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
  }

  return allSellPosts;
}

// Function to get the latest sell posts (limited to 3) from all users
Future<List<Map<String, dynamic>>> getLatestSellPosts() async {
  List<Map<String, dynamic>> latestSellPosts = [];
  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot = await userUidsRef.get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userSellsRef = FirebaseFirestore.instance
          .collection('sellPlants')
          .doc(userId)
          .collection('SellPlants');

      try {
        // Get a snapshot of the latest 3 sell posts for the current user, ordered by date in descending order
        QuerySnapshot userSellsSnapshot = await userSellsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .limit(3)
            .get();

        // Iterate through each sell post document
        for (final sellDoc in userSellsSnapshot.docs) {
          final sellData = sellDoc.data() as Map<String, dynamic>;
          // Add the sell data to the list
          latestSellPosts.add(sellData);
          // Process each sell data as needed
          print('User $userId Sell');
        }
      } catch (e) {
        // Handle errors when getting sells for a user
        print('Error getting sells for user $userId: $e');
      }
    }
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
  }

  return latestSellPosts;
}

// Function to get all sell posts from all users without additional processing
Future<List<Map<String, dynamic>>> getAllSellsList() async {
  List<Map<String, dynamic>> allSells = [];

  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot = await userUidsRef.get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection('sellPlants')
          .doc(userId)
          .collection('SellPlants');

      try {
        // Get a snapshot of sell posts for the current user, ordered by date in descending order
        QuerySnapshot userPostsSnapshot = await userPostsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .get();

        // Iterate through each sell post document and add data to the list
        for (final postDoc in userPostsSnapshot.docs) {
          final postData = postDoc.data() as Map<String, dynamic>;
          allSells.add(postData);
        }
      } catch (e) {
        // Handle errors when getting posts for a user
        print('Error getting posts for user $userId: $e');
      }
    }
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
  }

  return allSells;
}
