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

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  final _emilController = TextEditingController();
  final _passwordController = TextEditingController();

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emilController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSankBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSankBar(context, 'Wrong password provided for that user.');
      }
    } catch (e) {
      showSankBar(context, e.toString());
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
  void dispose() {
    _emilController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      height: 48,
                      width: 343,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _emilController,
                        cursorColor: tPrimaryActionColor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: tSecondActionColor,
                          ),
                          icon: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Icon(
                              Icons.email_outlined,
                              color: tSecondActionColor,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      height: 48,
                      width: 343,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: _passwordController,
                          cursorColor: tPrimaryActionColor,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(color: tSecondActionColor),
                            icon: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Icon(
                                Icons.lock_outline_rounded,
                                color: tSecondActionColor,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IntrinsicWidth(
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: tPrimaryActionColor,
                                side: const BorderSide(
                                  width: 1,
                                  color: tSecondActionColor,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                value: isRememberMe,
                                onChanged: (bool? value) {
                                  setState(
                                    () {
                                      isRememberMe = value!;
                                    },
                                  );
                                },
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(
                                  color: tSecondTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
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
                        )
                      ],
                    ),
                    SizedBox(height: height - 739),
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
