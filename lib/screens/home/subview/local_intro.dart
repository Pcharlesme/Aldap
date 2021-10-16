import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/controllers/location_controller.dart';
import 'package:delivery_dee/controllers/user_controllers.dart';
import 'package:delivery_dee/screens/home/subview/checkout.dart';
import 'package:delivery_dee/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class LocalIntro extends StatelessWidget {
  final UserController _userController = Get.find();
  final LocationController _locationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.blue[900]),
              onPressed: () => Get.back()),
        ),
        body: Obx(
          () => SingleChildScrollView(
                      child: Column(
              children: [
                Image.asset(logo),
                AutoSizeText(
                  "Get Started \n Lets get it done for you",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                // Align(
                //   alignment: Alignment.centerLeft,
                // child: AutoSizeText(
                //   "Recipient Name",
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 22.sp,
                //   ),
                // ),
                // ),
                ListTile(
                  title: AutoSizeText(
                    "Recipient Name",
                    style: TextStyle(color: Colors.grey),
                  ),
                  subtitle: AutoSizeText(
                    _userController.userData.value.name ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 15.h),
                ListTile(
                  title: AutoSizeText(
                    "Recipient Number",
                    style: TextStyle(color: Colors.grey),
                  ),
                  subtitle: AutoSizeText(
                    _userController.userData.value.phoneNumber ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 15.h),
                ListTile(
                  title: AutoSizeText(
                    "Recipient Address",
                    style: TextStyle(color: Colors.grey),
                  ),
                  subtitle: AutoSizeText(
                    _locationController.userAddress.value ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: CustomButton(
                        text: "Proceed",
                        onTap: () {
                          _userController.userData.value.phoneNumber == null
                              ? Get.snackbar(
                                  "Notice!",
                                  "Update your information",
                                )
                              : Get.to(Checkout());
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
