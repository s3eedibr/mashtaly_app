import 'package:flutter/material.dart';
import 'package:mashtaly_app/screens/reg_screen.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        child: Column(children: [
          Image.asset(
            tLoginImage1,
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
          SizedBox(height: 20),
          Container(
            child: Column(
              children: [
                Text(
                  "Welcome to Mashtaly",
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
                  child: SizedBox(
                    width: double.infinity,
                    child: TextField(
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
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
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IntrinsicWidth(
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: tPrimaryActionColor,
                            side: BorderSide(
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
                          Text(
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
                      onPressed: () {},
                      child: Text(
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
                SizedBox(height: height - 690),
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        width: 343,
                        height: 50,
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          fillColor: tPrimaryActionColor,
                          elevation: 0,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: tThirdTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(),
                            ),
                          );
                        },
                        style: ButtonStyle(),
                        child: Text.rich(
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
        ]),
      ),
    );
  }
}
