import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  GlobalKey<FormState> formKey = GlobalKey();

  Future registration() async {
    if (formKey.currentState!.validate()) {
      try {
        if (passwordConfirmed()) {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emilController.text.trim(),
                  password: _passwordController.text.trim())
              .then((value) => addUser())
              .then((value) => verifyEmail());
        } else {
          showSankBar(context, 'The password is not match.');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSankBar(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSankBar(context, 'The account already exists for that email.');
        }
      } catch (e) {
        showSankBar(context, e.toString());
      }
    }
  }

  void verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.updateDisplayName(_nameController.text.trim());
    await user.sendEmailVerification();
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

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("test");

  void addUser() async {
    try {
      await usersCollection.add({
        "email": _emilController.text.trim(),
        "name": _nameController.text.trim(),
      });
      print('User added successfully');
    } catch (e) {
      print('Error adding user: $e');
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
        backgroundColor: tBgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Center(
                    child: Image(
                      image: const AssetImage(tRegistrationImage1),
                      width: width - 25,
                    ),
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
                          obscureText: true,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: tSecondActionColor,
                              size: 28,
                            ),
                            hintText: "Confirm Password",
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: height - 744),
              GestureDetector(
                  onTap: registration,
                  child: Container(
                    decoration: BoxDecoration(
                      color: tPrimaryActionColor,
                      borderRadius: BorderRadius.circular(6),
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
      ),
    );
  }
}
