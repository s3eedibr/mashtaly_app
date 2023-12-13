// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:mashtaly_app/Auth/auth.dart';
import 'package:mashtaly_app/Constants/assets.dart';

import '../../../Constants/colors.dart';
import '../../Widget/snackBar.dart';
import 'forgotpassword_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.sendToEmail,
  }) : super(key: key);
  final String sendToEmail;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  void initState() {
    super.initState();
    sendOTP(); // Trigger the OTP sending process when the screen is initialized
  }

  EmailOTP myauth =
      EmailOTP(); // Instance of the EmailOTP class for OTP handling
  void sendOTP() async {
    myauth.setConfig(
      appEmail: "noreply@mashtaly-hu.firebaseapp.com",
      appName: "Mashtaly",
      userEmail: widget.sendToEmail,
      otpLength: 5,
      otpType: OTPType.digitsOnly,
    );

    // Send OTP and handle success or failure
    if (await myauth.sendOTP() == true) {
      showSnackBar(context, 'OTP has been sent to your email',
          color: tPrimaryActionColor);
    } else {
      // Navigate back to the Forgot Password screen if OTP sending fails
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        ),
      );
    }
  }

  String? veryOTP; // Variable to store the user-entered OTP

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(
                child: Image(
                  image: const AssetImage(
                      Assets.assetsImagesResetpasswordImagesResetpassword2),
                  width: width - 25,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  Text(
                    "Enter OTP received on your email ${widget.sendToEmail}",
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
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      borderColor: Colors.white,
                      focusedBorderColor: tPrimaryActionColor,
                      onSubmit: (code) {
                        veryOTP = code;
                      }),
                  const SizedBox(height: 30),
                  Text.rich(
                    TextSpan(
                      text: "Don't receive OTP?",
                      style: const TextStyle(
                        color: tPrimaryTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                            text: " Resend OTP",
                            style: const TextStyle(
                              color: tPrimaryActionColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                sendOTP(); // Resend OTP when the "Resend OTP" button is pressed
                              }),
                      ],
                    ),
                  ),
                  SizedBox(height: height - 680),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 343,
                          height: 50,
                          child: RawMaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
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
                            onPressed: () async {
                              // Verify the entered OTP and proceed accordingly
                              if (await myauth.verifyOTP(otp: veryOTP) ==
                                  true) {
                                showSnackBar(context,
                                    'Check your email to reset your password',
                                    color: tPrimaryActionColor);
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Auth(),
                                  ),
                                );
                              } else {
                                showSnackBar(context, 'Invalid OTP');
                              }
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
    );
  }
}
