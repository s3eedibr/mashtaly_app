import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> initUserStatus() async {
  // Wait for the result of isActive before continuing
  bool userIsActive = await isActive();

  if (!userIsActive) {
    // User is not active, log them out
    await FirebaseAuth.instance.signOut();
  }
}

Future<bool> isActive() async {
  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userSnapshot.exists) {
      // Check the 'active' field in the user document
      bool isActive = userSnapshot.get('active') ?? false;
      return isActive;
    } else {
      // User document does not exist, handle accordingly
      return false;
    }
  } catch (e) {
    print('Error checking user status: $e');
    // Handle errors, e.g., lack of permissions
    return false;
  }
}
