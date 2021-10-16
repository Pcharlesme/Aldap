import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/screens/authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboarding/onboarding.dart';
import 'package:get/get.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final storage = GetStorage();
  final onboardingPagesList = [
    PageModel(
      assetPath: boarding1,
      title: 'DOOR TO DOOR',
      info: "Ship and track Parcels and Packages to your door step",
    ),
    PageModel(
      assetPath: boarding2,
      title: 'FAST DELIVERY',
      info:
          'Ship and track Parcels and Packages and learn about Double Dee courier service',
    ),
    PageModel(
      assetPath: boarding3,
      title: 'SECURE DELIVERY',
      info: 'Ship and track Parcels and Packages with zero risks',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(
        
        skipButtonStyle: SkipButtonStyle(
          skipButtonColor: Colors.blue[900]
        ),
        pagesImageColor: null,
        titleStyle: TextStyle(color: Colors.black),
        infoStyle: TextStyle(color: Colors.black),
        background: Colors.white,
        proceedButtonStyle: ProceedButtonStyle(
          proceedButtonColor: Colors.blue[900],
            proceedButtonRoute: (context) {
              storage.write("FreshInstall", false);
              return Get.offAll(AuthenticationScreen());
            },
            proceedButtonText: 'Sign Up'),
        pages: onboardingPagesList,
        indicator: Indicator(
          indicatorDesign: IndicatorDesign.line(
            lineDesign: LineDesign(
              lineType: DesignType.line_uniform,
            ),
          ),
        ),
      ),
    );
  }
}
