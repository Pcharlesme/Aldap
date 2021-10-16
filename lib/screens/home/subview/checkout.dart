import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_dee/controllers/app_controller.dart';
import 'package:delivery_dee/controllers/location_controller.dart';
import 'package:delivery_dee/controllers/user_controllers.dart';
import 'package:delivery_dee/screens/home/subview/location.dart';
import 'package:delivery_dee/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class Checkout extends StatelessWidget {
  final LocationController _locationController = Get.find();
  final UserController _userController = Get.find();
  final AppController _appController = Get.find();
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
          title: AutoSizeText(
            "Checkout",
            style: TextStyle(color: Colors.blue[900]),
          ),
        ),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Delivery",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Address Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      AutoSizeText(
                        "Change",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 20.vh,
                      width: 90.vw,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 4,
                              offset: Offset(4, 8),
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            _userController.userData.value.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          Divider(),
                          AutoSizeText(
                            _locationController.userAddress.value,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          Divider(),
                          AutoSizeText(
                            _userController.userData.value.phoneNumber,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Delivery",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        // height: 50.vh,
                        width: 90.vw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              onTap: () => _appController.toDoorDelivery(),
                              leading: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: _appController.doorDeliveryMethod.value
                                      ? Icon(
                                          Icons.check,
                                          size: 30.0,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.check_box_outline_blank,
                                          size: 30.0,
                                          color: Colors.blue,
                                        ),
                                ),
                              ),
                              title: AutoSizeText(
                                "Door Delivery",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () =>
                                  _appController.toPickUpDelivery(),
                              leading: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                      _appController.pickUpDeliveryMethod.value
                                          ? Icon(
                                              Icons.check,
                                              size: 30.0,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.check_box_outline_blank,
                                              size: 30.0,
                                              color: Colors.blue,
                                            ),
                                ),
                              ),
                              title: AutoSizeText(
                                "Pick Up",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () =>
                                  _appController.toNoContactDelivery(),
                              leading: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: _appController
                                          .noContactDeliveryMethod.value
                                      ? Icon(
                                          Icons.check,
                                          size: 30.0,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.check_box_outline_blank,
                                          size: 30.0,
                                          color: Colors.blue,
                                        ),
                                ),
                              ),
                              title: AutoSizeText(
                                "No Contact Delivery",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      text: "Proceed",
                      onTap: () => Get.to(Location()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
