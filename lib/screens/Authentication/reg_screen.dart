// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mashtaly_app/Auth/auth.dart';

import '../../Constants/colors.dart';
import '../../Constants/image_strings.dart';

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
  final _nameController = TextEditingController();
  final _emilController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  Future registration() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emilController.text.trim(),
          password: _passwordController.text.trim());
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Image(
                      image: AssetImage(tRegistrationImage1),
                      width: width - 25,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Form(
                  child: Column(
                    children: [
                      Text(
                        "Let's Join Our Community",
                        style: TextStyle(
                          color: tPrimaryTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 48,
                        width: 343,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _nameController,
                          cursorColor: tPrimaryActionColor,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
                            hintStyle: TextStyle(
                              color: tSecondActionColor,
                            ),
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Icon(
                                Icons.person_2_outlined,
                                color: tSecondActionColor,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
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
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: tSecondActionColor,
                            ),
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Icon(
                                Icons.email_outlined,
                                color: tSecondActionColor,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 48,
                        width: 343,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _passwordController,
                          cursorColor: tPrimaryActionColor,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: tSecondActionColor,
                            ),
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Icon(
                                Icons.lock_outline_rounded,
                                color: tSecondActionColor,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
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
                            controller: _confirmpasswordController,
                            cursorColor: tPrimaryActionColor,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: tSecondActionColor),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 15),
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: height - 719),
              GestureDetector(
                  onTap: registration,
                  child: Container(
                    decoration: BoxDecoration(
                      color: tPrimaryActionColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 343,
                    height: 50,
                    child: Center(
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
              SizedBox(height: 15),
              GestureDetector(
                onTap: widget.showLoginScreen,
                child: Text.rich(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
