import '../../Constants/assets.dart';
import '../../Constants/text_strings.dart';

class OnBoardingModel {
  String img;
  String text;
  String desc;

  OnBoardingModel({required this.img, required this.text, required this.desc});
}

List<OnBoardingModel> screens = <OnBoardingModel>[
  OnBoardingModel(
      img: Assets.assetsImagesOnboardingImagesOnboarding1,
      text: tOnBoardingTitle1,
      desc: tOnBoardingSubTitle1),
  OnBoardingModel(
      img: Assets.assetsImagesOnboardingImagesOnboarding2,
      text: tOnBoardingTitle2,
      desc: tOnBoardingSubTitle2),
  OnBoardingModel(
      img: Assets.assetsImagesOnboardingImagesOnboarding3,
      text: tOnBoardingTitle3,
      desc: tOnBoardingSubTitle3),
];
