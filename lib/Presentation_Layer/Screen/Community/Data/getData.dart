import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<ConnectivityResult> checkConnectivity() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult;
}

Future<bool> isLoading() async {
  await Future.delayed(const Duration(milliseconds: 2500));
  return true;
}

Future<List<Map<String, dynamic>>> getAllPosts() async {
  List<Map<String, dynamic>> allPosts = [];
  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    final userUidsSnapshot = await userUidsRef.get();

    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('Posts');

      try {
        QuerySnapshot userPostsSnapshot = await userPostsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .get();

        for (final postDoc in userPostsSnapshot.docs) {
          final postData = postDoc.data() as Map<String, dynamic>;
          allPosts.add(postData); // Accumulate posts in the list
          // Process each post data as needed
          print('User $userId Post:');
        }
      } catch (e) {
        print('Error getting posts for user $userId: $e');
      }
    }

    return allPosts; // Return the accumulated posts
  } catch (e) {
    print('Error getting user documents: $e');
    return []; // Return an empty list in case of an error
  }
}

Future<List<Map<String, dynamic>>> getLatestPosts() async {
  List<Map<String, dynamic>> latestPosts = [];

  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    final userUidsSnapshot = await userUidsRef.get();

    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('Posts');

      try {
        QuerySnapshot userPostsSnapshot = await userPostsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .limit(3)
            .get();

        for (final postDoc in userPostsSnapshot.docs) {
          final postData = postDoc.data() as Map<String, dynamic>;
          latestPosts.add(postData);
          // Process each post data as needed
          print('User $userId Post:');
        }
      } catch (e) {
        print('Error getting posts for user $userId: $e');
      }
    }

    return latestPosts;
  } catch (e) {
    print('Error getting user documents: $e');
    return []; // Return an empty list in case of an error
  }
}

Future<List<Map<String, dynamic>>> getAllPostsList() async {
  List<Map<String, dynamic>> allPosts = [];

  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    final userUidsSnapshot = await userUidsRef.get();

    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('Posts');

      try {
        QuerySnapshot userPostsSnapshot = await userPostsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .get();

        for (final postDoc in userPostsSnapshot.docs) {
          final postData = postDoc.data() as Map<String, dynamic>;
          allPosts.add(postData);
        }
      } catch (e) {
        print('Error getting posts for user $userId: $e');
      }
    }
  } catch (e) {
    print('Error getting user documents: $e');
  }

  return allPosts;
}

Future<List<Map<String, dynamic>>> getAllSellPosts() async {
  List<Map<String, dynamic>> allSellPosts = [];
  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    final userUidsSnapshot = await userUidsRef.get();

    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userSellsRef = FirebaseFirestore.instance
          .collection('sellPlants')
          .doc(userId)
          .collection('SellPlants');

      try {
        QuerySnapshot userSellsSnapshot = await userSellsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .get();

        for (final sellDoc in userSellsSnapshot.docs) {
          final sellData = sellDoc.data() as Map<String, dynamic>;
          // Process each sell data as needed
          print('User $userId Sell:');
          allSellPosts.add(sellData);
        }
      } catch (e) {
        print('Error getting sells for user $userId: $e');
      }
    }
  } catch (e) {
    print('Error getting user documents: $e');
  }

  return allSellPosts;
}

Future<List<Map<String, dynamic>>> getLatestSellPosts() async {
  List<Map<String, dynamic>> latestSellPosts = [];
  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    final userUidsSnapshot = await userUidsRef.get();

    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userSellsRef = FirebaseFirestore.instance
          .collection('sellPlants')
          .doc(userId)
          .collection('SellPlants');

      try {
        QuerySnapshot userSellsSnapshot = await userSellsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .limit(3)
            .get();

        for (final sellDoc in userSellsSnapshot.docs) {
          final sellData = sellDoc.data() as Map<String, dynamic>;
          // Process each sell data as needed
          print('User $userId Sell');
          latestSellPosts.add(sellData);
        }
      } catch (e) {
        print('Error getting sells for user $userId: $e');
      }
    }
  } catch (e) {
    print('Error getting user documents: $e');
  }

  return latestSellPosts;
}

Future<List<Map<String, dynamic>>> getAllSellsList() async {
  List<Map<String, dynamic>> allSells = [];

  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    final userUidsSnapshot = await userUidsRef.get();

    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection('sellPlants')
          .doc(userId)
          .collection('SellPlants');

      try {
        QuerySnapshot userPostsSnapshot = await userPostsRef
            .where('posted', isEqualTo: true)
            .orderBy('date', descending: true)
            .get();

        for (final postDoc in userPostsSnapshot.docs) {
          final postData = postDoc.data() as Map<String, dynamic>;
          allSells.add(postData);
        }
      } catch (e) {
        print('Error getting posts for user $userId: $e');
      }
    }
  } catch (e) {
    print('Error getting user documents: $e');
  }

  return allSells;
}
