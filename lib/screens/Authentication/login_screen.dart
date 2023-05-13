import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants/colors.dart';
import '../../Constants/image_strings.dart';
import 'forgotpassword_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegScreen;
  const LoginScreen({
    Key? key,
    required this.showRegScreen,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  bool isRememberMe = false;
  final _emilController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  AppLifecycleState? _lastLifecycleState;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _lastLifecycleState == AppLifecycleState.paused) {
      if (isRememberMe == false) {
        FirebaseAuth.instance.signOut();
      }
    } else if (state == AppLifecycleState.paused &&
        _lastLifecycleState == AppLifecycleState.resumed) {
      if (isRememberMe == false) {
        FirebaseAuth.instance.signOut();
      }
    }
    _lastLifecycleState = state;
  }

  Future login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emilController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _emilController.dispose();
    _passwordController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          child: Column(
            children: [
              Image(
                image: AssetImage(tLoginImage1),
                width: width,
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
                        controller: _emilController,
                        cursorColor: tPrimaryActionColor,
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
                          controller: _passwordController,
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
                    SizedBox(height: 10),
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
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(),
                              ),
                            );
                          },
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
                    SizedBox(height: height - 739),
                    Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: login,
                            child: Container(
                              decoration: BoxDecoration(
                                color: tPrimaryActionColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: 343,
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: tThirdTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: widget.showRegScreen,
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
