import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants/colors.dart';
import '../../Constants/image_strings.dart';
import 'forgotpassword_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegScreen;
  const LoginScreen({
    Key? key,
    required this.showRegScreen,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final _emilController = TextEditingController();
  final _passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  Future login() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emilController.text.trim(),
            password: _passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSankBar(context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showSankBar(context, 'Wrong password provided for that user.');
        } else if (e.code == 'user-disabled') {
          showSankBar(context,
              'The user account has been disabled by an administrator.');
        }
      } catch (e) {
        showSankBar(context, e.toString());
      }
    }
  }

  void showSankBar(BuildContext context, String message,
      {Color color = tThirdTextErrorColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _emilController.dispose();
    _passwordController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: tBgColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          child: Column(
            children: [
              Image(
                image: const AssetImage(tLoginImage1),
                width: width,
              ),
              const SizedBox(height: 20),
              Container(
                child: Form(
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
                                Radius.circular(6),
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
                          obscureText: true,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: tSecondActionColor,
                              size: 28,
                            ),
                            hintText: "Password",
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
                                Radius.circular(6),
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
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
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
                      SizedBox(height: height - 718),
                      Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: login,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: tPrimaryActionColor,
                                  borderRadius: BorderRadius.circular(6),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
