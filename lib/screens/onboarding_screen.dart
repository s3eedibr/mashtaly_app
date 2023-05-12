import 'package:mashtaly_app/Models/onboarding_model.dart';
import 'package:mashtaly_app/Auth/auth.dart';
import 'package:mashtaly_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnBoaringInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Auth(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Auth(),
                  ),
                );
              },
              child: Row(
                children: [
                  currentIndex != 2
                      ? Text(
                          "Skip",
                          style: TextStyle(
                            color: tPrimaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      : Text(""),
                  currentIndex != 2
                      ? Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: tPrimaryTextColor,
                          size: 24,
                        )
                      : Text(""),
                ],
              ),
            ),
          ],
        ),
        body: PageView.builder(
          itemCount: screens.length,
          controller: _pageController,
          physics: PageScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  screens[index].img,
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          screens[index].text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: tPrimaryTextColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6, right: 6),
                        child: Text(
                          screens[index].desc,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: tPrimaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 10,
                      child: ListView.builder(
                        itemCount: screens.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                height: 8,
                                width: currentIndex == index ? 25 : 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? tPrimaryActionColor
                                      : tSecondActionColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: TextButton(
                          onPressed: () async {
                            await _storeOnBoaringInfo();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Auth(),
                              ),
                            );
                          },
                          child: Text(
                            "Don't show again",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: tSecondActionColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (index == screens.length - 1) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Auth()));
                        }
                        _pageController.nextPage(
                          duration: Duration(microseconds: 300),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 12,
                                    offset: Offset(0, 3),
                                    color: Color(0x33000000)),
                                BoxShadow(
                                    offset: Offset(-10, 0),
                                    color: Colors.white),
                                BoxShadow(
                                    offset: Offset(10, 0), color: Colors.white),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 380,
                            decoration: BoxDecoration(
                                color: tPrimaryActionColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                currentIndex != 2
                                    ? Text(
                                        "Next",
                                        style: TextStyle(
                                          color: tThirdTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )
                                    : Text(
                                        "Let's Get Started",
                                        style: TextStyle(
                                          color: tThirdTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
