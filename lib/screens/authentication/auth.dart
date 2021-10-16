import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/constants/controllers.dart';
import 'package:delivery_dee/screens/authentication/widgets/bottom_text.dart';
import 'package:delivery_dee/screens/authentication/widgets/login.dart';
import 'package:delivery_dee/screens/authentication/widgets/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => SingleChildScrollView(
            child: Stack(
              children: [
                // Image.asset(
                //   bg1,
                //   width: double.infinity,
                //   // height: MediaQuery.of(context).size.height,
                //   // fit: BoxFit.cover,
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),
                    Image.asset(
                      logo,
                      width: 200,
                    ),
                    SizedBox(height: 50.h),
                    Visibility(
                        visible: appController.isLoginWidgetDisplayed.value,
                        child: LoginWidget()),
                    Visibility(
                        visible: !appController.isLoginWidgetDisplayed.value,
                        child: RegistrationWidget()),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: appController.isLoginWidgetDisplayed.value,
                      child: BottomTextWidget(
                        onTap: () {
                          appController.changeDisplayedAuthWidget();
                        },
                        text1: "Don\'t have an account?",
                        text2: "Create account!",
                      ),
                    ),
                    Visibility(
                      visible: !appController.isLoginWidgetDisplayed.value,
                      child: BottomTextWidget(
                        onTap: () {
                          appController.changeDisplayedAuthWidget();
                        },
                        text1: "Already have an account?",
                        text2: "Sign in!!",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
