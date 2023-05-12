import 'package:flutter/material.dart';
import 'package:mashtaly_app/Auth/auth.dart';

import '../../Constants/colors.dart';
import '../../Constants/image_strings.dart';
import 'forgotpassword_screen.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

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
                      image: AssetImage(tRegistrationImage2),
                      width: width - 120,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    Text(
                      "We sent you an email to verify your account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: tPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 45),
                    SizedBox(height: height - 565),
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
                                "Let's Get Started",
                                style: TextStyle(
                                  color: tThirdTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Auth(),
                                  ),
                                );
                              },
                            ),
                          ),
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
