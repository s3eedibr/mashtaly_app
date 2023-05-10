import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
            width: 340,
            height: 185,
            tRegistrationImage1,
            fit: BoxFit.cover,
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
