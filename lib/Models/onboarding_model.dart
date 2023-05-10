import 'package:flutter/material.dart';

import '../constants/image_strings.dart';
import '../constants/text_strings.dart';

class OnBoardingModel {
  String img;
  String text;
  String desc;

  OnBoardingModel({required this.img, required this.text, required this.desc});
}

List<OnBoardingModel> screens = <OnBoardingModel>[
  OnBoardingModel(
      img: tOnBoardingImage1,
      text: tOnBoardingTitle1,
      desc: tOnBoardingSubTitle1),
  OnBoardingModel(
      img: tOnBoardingImage2,
      text: tOnBoardingTitle2,
      desc: tOnBoardingSubTitle2),
  OnBoardingModel(
      img: tOnBoardingImage3,
      text: tOnBoardingTitle3,
      desc: tOnBoardingSubTitle3),
];
