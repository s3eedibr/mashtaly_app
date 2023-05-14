import 'package:flutter/material.dart';
import 'package:mashtaly_app/Auth/auth.dart';

import '../../Constants/colors.dart';
import '../../Constants/image_strings.dart';
import '../../Constants/text_strings.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                  padding: const EdgeInsets.only(top: 84),
                  child: Center(
                    child: Image(
                      image: const AssetImage(tResetPasswordImage3),
                      width: width - 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    const Text(
                      tResetPass,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: tPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 45),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      height: 48,
                      width: 343,
                      alignment: Alignment.center,
                      child: const TextField(
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
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      height: 48,
                      width: 343,
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: double.infinity,
                        child: TextField(
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
                    SizedBox(height: height - 694),
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
                              child: const Text(
                                "Reset Password",
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
                                    builder: (context) => const Auth(),
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
