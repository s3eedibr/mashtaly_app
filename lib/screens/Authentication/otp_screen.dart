import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mashtaly_app/Screens/Authentication/resetpassword.dart';

import '../../Constants/colors.dart';
import '../../Constants/image_strings.dart';
import 'forgotpassword_screen.dart';

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
                      image: const AssetImage(tResetPasswordImage2),
                      width: width - 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    Text(
                      "Enter OTP received on your email $email",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: tPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 45),
                    const SizedBox(height: 25),
                    OtpTextField(
                      cursorColor: tPrimaryActionColor,
                      numberOfFields: 5,
                      fieldWidth: 50,
                      showCursor: true,
                      fillColor: Colors.white,
                      filled: true,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      borderColor: Colors.white,
                      focusedBorderColor: tPrimaryActionColor,
                      onSubmit: (code) {
                        print("OTP is => $code");
                      },
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      style: const ButtonStyle(),
                      child: const Text.rich(
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
                              child: const Text(
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
                                    builder: (context) =>
                                        const ResetPasswordScreen(),
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
