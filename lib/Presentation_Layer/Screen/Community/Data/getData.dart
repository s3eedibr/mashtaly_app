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

Future<void> getAllPosts() async {
  final db = FirebaseFirestore.instance;

  final userUidsRef = db.collection('users');
  final getAllPostsRef = db.collection('getAllPosts');

  try {
    final userUidsSnapshot = await userUidsRef.get();

    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef =
          db.collection('posts').doc(userId).collection('Posts');

      final userPostsSnapshot =
          await userPostsRef.where('posted', isEqualTo: true).get();

      for (final postDoc in userPostsSnapshot.docs) {
        final postId = postDoc.id;
        final postData = postDoc.data();

        // Check if the "posted" flag is true before adding to getAllPosts
        if (postData['posted'] == true) {
          // Add the post to getAllPosts collection group
          await getAllPostsRef.doc(postId).set(postData);
          print('Post added to getAllPosts collection group: $postId');
        } else {
          print('Post skipped (not posted): $postId');
        }
      }
    }
  } catch (error) {
    print('Error creating getAllPosts collection group: $error');
  }
}

Future<void> getAllSells() async {
  final db = FirebaseFirestore.instance;

  final userUidsRef = db.collection('users');
  final getAllSellsRef = db.collection('getAllSells');

  try {
    final userUidsSnapshot = await userUidsRef.get();

    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef =
          db.collection('sellPlants').doc(userId).collection('SellPlants');

      final userSellsSnapshot =
          await userPostsRef.where('posted', isEqualTo: true).get();

      for (final postDoc in userSellsSnapshot.docs) {
        final postId = postDoc.id;
        final postData = postDoc.data();

        // Check if the "posted" flag is true before adding to getAllPosts
        if (postData['posted'] == true) {
          // Add the post to getAllPosts collection group
          await getAllSellsRef.doc(postId).set(postData);
          print('Post added to getAllSells collection group: $postId');
        } else {
          print('Post skipped (not posted): $postId');
        }
      }
    }
  } catch (error) {
    print('Error creating getAllPosts collection group: $error');
  }
}
