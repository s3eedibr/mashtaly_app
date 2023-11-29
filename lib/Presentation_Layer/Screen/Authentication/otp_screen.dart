// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:mashtaly_app/Auth/auth.dart';
import 'package:mashtaly_app/Constants/assets.dart';

import '../../../Constants/colors.dart';
import '../../Widget/sankBar.dart';
import 'forgotpassword_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.sendtoemail,
  }) : super(key: key);
  final String sendtoemail;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendOTP();
  }

  EmailOTP myauth = EmailOTP();
  void sendOTP() async {
    myauth.setConfig(
      appEmail: "noreply@mashtaly-hu.firebaseapp.com",
      appName: "Mashtaly",
      userEmail: widget.sendtoemail,
      otpLength: 5,
      otpType: OTPType.digitsOnly,
    );
    if (await myauth.sendOTP() == true) {
      showSnakBar(context, 'OTP has been sent to your email',
          color: tPrimaryActionColor);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        ),
      );
    }
  }

  String? veryOTP;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Center(
                  child: Image(
                    image: const AssetImage(
                        Assets.assetsImagesResetpasswordImagesResetpassword2),
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
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      sendOTP();
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
                  SizedBox(height: height - 720),
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
                              if (await myauth.verifyOTP(otp: veryOTP) ==
                                  true) {
                                showSnakBar(context,
                                    'Check your email to reset your password',
                                    color: tPrimaryActionColor);
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email!);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Auth(),
                                  ),
                                );
                              } else {
                                showSnakBar(context, 'Invalid OTP');
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
