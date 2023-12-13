import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_app/Constants/assets.dart';

import '../../../Constants/colors.dart';
import '../../Widget/snackBar.dart';
import 'forgotpassword_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback
      showRegScreen; // Callback function to show the registration screen
  const LoginScreen({
    Key? key,
    required this.showRegScreen,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  // Declare controllers for email and password input fields
  final _emilController = TextEditingController();
  final _passwordController = TextEditingController();

  // Variable to control password visibility
  bool _showPassword = false;

  // Form key to validate user input
  GlobalKey<FormState> formKey = GlobalKey();

  // Function to handle user login
  Future login() async {
    // Check if form is valid
    if (formKey.currentState!.validate()) {
      try {
        // Sign in user using Firebase Authentication
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emilController.text.trim(),
            password: _passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        // Handle Firebase Authentication errors
        switch (e.code) {
          case 'user-not-found':
            showSnackBar(context, 'No user found for that email.');
            break;
          case 'wrong-password':
            showSnackBar(context, 'Wrong password provided for that user.');
            break;
          case 'user-disabled':
            showSnackBar(context,
                'The user account has been disabled by an administrator.');
            break;
          case 'invalid-email':
            showSnackBar(context, 'The email address is badly formatted.');
            break;
          default:
            showSnackBar(context, e.toString());
        }
      } catch (e) {
        // Handle generic errors
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(this); // Add state observer for lifecycle changes
  }

  @override
  void dispose() {
    _emilController.dispose(); // Dispose controllers to avoid memory leaks
    _passwordController.dispose();
    WidgetsBinding.instance.removeObserver(this); // Remove state observer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: tBgColor,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: false,
        child: Column(
          children: [
            Image(
              image: const AssetImage(Assets.assetsImagesLoginPage),
              width: width,
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    "Welcome to Mashtaly",
                    style: TextStyle(
                      color: tPrimaryTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 25),
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
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
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
                        obscureText: !_showPassword,
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: tSecondActionColor,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: tPrimaryActionColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(height: height - 682),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: login,
                        child: Container(
                          decoration: BoxDecoration(
                            color: tPrimaryActionColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 343,
                          height: 50,
                          child: const Center(
                            child: Text(
                              "Login",
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
                      GestureDetector(
                        onTap: widget.showRegScreen,
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
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
