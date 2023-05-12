import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mashtaly_app/screens/forgotpassword_screen.dart';
import 'package:mashtaly_app/screens/reg_screen.dart';
import 'package:mashtaly_app/screens/resetpassword.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';
import '../constants/text_strings.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

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
                      image: AssetImage(tResetPasswordImage2),
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
                      "Enter OTP received on your email $email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: tPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 45),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(6),
                    //   ),
                    //   height: 48,
                    //   width: 343,
                    //   alignment: Alignment.center,
                    //   child: TextField(
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: 16,
                    //     ),
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: "Email",
                    //       hintStyle: TextStyle(
                    //         color: tSecondActionColor,
                    //       ),
                    //       icon: Padding(
                    //         padding: const EdgeInsets.only(left: 15),
                    //         child: Icon(
                    //           Icons.email_outlined,
                    //           color: tSecondActionColor,
                    //           size: 28,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 25),
                    OtpTextField(
                      cursorColor: tPrimaryActionColor,
                      numberOfFields: 5,
                      fieldWidth: 50,
                      showCursor: true,
                      fillColor: Colors.white,
                      filled: true,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      borderColor: Colors.white,
                      focusedBorderColor: tPrimaryActionColor,
                      onSubmit: (code) {
                        print("OTP is => $code");
                      },
                    ),
                    SizedBox(height: 5),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(),
                      child: Text.rich(
                        TextSpan(
                          text: "Don't receive OTP?",
                          style: TextStyle(
                            color: tPrimaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: " Resend OTP",
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
                    SizedBox(height: height - 710),
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
                                "Confirm",
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
                                    builder: (context) => ResetPasswordScreen(),
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
