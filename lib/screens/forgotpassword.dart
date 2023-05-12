import 'package:flutter/material.dart';
import 'package:mashtaly_app/constants/image_strings.dart';
import 'package:mashtaly_app/screens/reg_screen.dart';

import '../constants/colors.dart';
import '../constants/text_strings.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                  padding: const EdgeInsets.only(top: 70),
                  child: Center(
                    child: Image(
                      image: AssetImage(tResetPasswordImage1),
                      width: width - 25,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    Text(
                      tEmailAcc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: tPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 45),
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
                    SizedBox(height: height - 699),
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
                                "Send Instructions",
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
            ],
          ),
        ),
      ),
    );
  }
}
