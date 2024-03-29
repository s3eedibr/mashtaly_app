import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_app/Constants/assets.dart';
import '../../Widget/snackBar.dart';

import '../../../Constants/colors.dart';

class RegistrationScreen extends StatefulWidget {
  final VoidCallback showLoginScreen;
  const RegistrationScreen({
    Key? key,
    required this.showLoginScreen,
  }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers for user input
  final _nameController = TextEditingController();
  final _emilController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  // Form key for validation
  GlobalKey<FormState> formKey = GlobalKey();

  /// Handles user registration
  Future registration() async {
    // Validate the form first
    if (formKey.currentState!.validate()) {
      try {
        // Check if passwords match
        if (passwordConfirmed()) {
          // Create a new user using Firebase Auth
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emilController.text.trim(),
                  password: _passwordController.text.trim())
              // Add the user to Firestore
              .then((value) => addUser())
              // Verify the user's email address
              .then((value) => verifyEmail());
        } else {
          // Show error message if passwords don't match
          showSnackBar(context, 'The password is not match.');
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase Auth exceptions
        switch (e.code) {
          case 'weak-password':
            showSnackBar(context, 'The password provided is too weak.');
            break;
          case 'email-already-in-use':
            showSnackBar(context, 'The account already exists for that email.');
            break;
          default:
            showSnackBar(context, e.toString());
        }
      } catch (e) {
        // Handle general errors
        showSnackBar(context, e.toString());
      }
    }
  }

  /// Verifies the user's email address
  void verifyEmail() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser!;

    // Update the user's display name
    await user.updateDisplayName(_nameController.text.trim());

    // Send email verification link
    await user.sendEmailVerification();
  }

  Future<String> getToken() async {
    try {
      final String? token = await FirebaseMessaging.instance.getToken();
      if (token == null) return '';
      return token;
    } catch (e) {
      return '';
    }
  }

  /// Accesses the users collection in Firestore
  final usersCollection = FirebaseFirestore.instance.collection('users');

  /// Adds the new user to Firestore
  Future<void> addUser() async {
    // Get the current user
    final currentUser = FirebaseAuth.instance.currentUser;

    // Check if there is a current user
    if (currentUser == null) {
      print('Error: No currently signed-in user');
      return;
    }

    try {
      // Add the user's email and name to the database
      await usersCollection.doc(currentUser.uid).set({
        "id": currentUser.uid,
        "email": _emilController.text.trim(),
        "name": _nameController.text.trim(),
        "profile_pic":
            'https://firebasestorage.googleapis.com/v0/b/mashtaly-hu.appspot.com/o/default_profile.jpg?alt=media&token=c2365fe7-8e7d-4674-9c13-c88fc9f43b03',
        "isAdmin": false,
        "active": true,
        "token": await getToken(),
        "date": '${DateTime.now().toUtc()}',
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  /// Checks if the passwords match
  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmpasswordController.text.trim();
  }

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: tBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(
                child: Image(
                  image:
                      const AssetImage(Assets.assetsImagesRegistrationImages2),
                  width: width - 25,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      "Let's Join Our Community",
                      style: TextStyle(
                        color: tPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        cursorColor: tPrimaryActionColor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          prefixIcon: Icon(
                            Icons.person_2_outlined,
                            color: tSecondActionColor,
                            size: 28,
                          ),
                          hintText: "Name",
                          hintStyle: TextStyle(color: tSecondActionColor),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: tPrimaryActionColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: tPrimaryActionColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emilController,
                        cursorColor: tPrimaryActionColor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: tSecondActionColor,
                            size: 28,
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(color: tSecondActionColor),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: tPrimaryActionColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: tPrimaryActionColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        },
                        controller: _passwordController,
                        cursorColor: tPrimaryActionColor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: tSecondActionColor,
                            size: 28,
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: tSecondActionColor),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: tSecondActionColor,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: tPrimaryActionColor,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: tPrimaryActionColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        },
                        controller: _confirmpasswordController,
                        cursorColor: tPrimaryActionColor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: tSecondActionColor,
                            size: 28,
                          ),
                          hintText: "Confirm Password",
                          hintStyle: const TextStyle(color: tSecondActionColor),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: tSecondActionColor,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: tPrimaryActionColor,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: tPrimaryActionColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height - 705),
            GestureDetector(
                onTap: registration,
                child: Container(
                  decoration: BoxDecoration(
                    color: tPrimaryActionColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: 343,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: tThirdTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: widget.showLoginScreen,
              child: const Text.rich(
                TextSpan(
                  text: "Already have an account?",
                  style: TextStyle(
                    color: tPrimaryTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  children: [
                    TextSpan(
                      text: " Login now",
                      style: TextStyle(
                        color: tPrimaryActionColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
