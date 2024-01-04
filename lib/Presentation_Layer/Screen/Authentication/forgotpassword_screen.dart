import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Auth/auth.dart';
import '../../../Constants/assets.dart';
import '../../../Constants/colors.dart';
import '../../../Constants/text_strings.dart';
import '../../Widget/snackBar.dart';
import 'otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

String email = '';

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emilController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  // Function to check if the provided string is a valid email
  bool isEmail(String em) {
    String p = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  // Function to check if the email exists in the Firestore 'users' collection
  Future<bool> doesEmailExist(String email) async {
    try {
      // Reference to the Firestore collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Query for a document where the 'email' field matches the specified email
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();

      // Check if any documents were found
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false; // Return false in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image for the top of the screen
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(
                child: Image(
                  image: const AssetImage(
                      Assets.assetsImagesResetpasswordImagesResetpassword1),
                  width: width - 25,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                // Text for the title of the screen
                const Padding(
                  padding: EdgeInsets.only(left: 17, right: 16),
                  child: Text(
                    tEmailAcc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: tPrimaryTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                // Form with an email input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emilController,
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
                ),
                SizedBox(height: height - 670),
                Column(
                  children: [
                    // Button to send instructions for password reset
                    GestureDetector(
                      onTap: () async {
                        email = emilController.text.trim();
                        if (emilController.text.isEmpty) {
                          showSnackBar(context, 'Enter your email please.');
                        } else if (!isEmail(emilController.text.trim())) {
                          showSnackBar(
                              context, 'The email address is badly formatted.');
                        } else if (await doesEmailExist(
                            emilController.text.trim())) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPScreen(
                                  sendToEmail: emilController.text.trim()),
                            ),
                          );
                          showSnackBar(
                              context, 'OTP has been sent to your email',
                              color: tPrimaryActionColor);
                        } else {
                          showSnackBar(
                              context, 'No user found for that email.');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: tPrimaryActionColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: 343,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Send Instructions",
                            style: TextStyle(
                              color: tThirdTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Text to navigate to the registration screen
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Auth()),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                            color: tPrimaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: " Register now",
                              style: TextStyle(
                                color: tPrimaryActionColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
