import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/controllers/app_controller.dart';
import 'package:delivery_dee/controllers/location_controller.dart';
import 'package:delivery_dee/controllers/user_controllers.dart';
import 'package:delivery_dee/screens/home/pageview/home.dart';
import 'package:delivery_dee/screens/home/pageview/no_history.dart';
import 'package:delivery_dee/screens/home/pageview/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:resize/resize.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProfileDetails extends StatelessWidget {
  final UserController _userController = Get.find();
  final LocationController _locationController = Get.find();
  final AppController _appController = Get.find();
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blue[900],
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text('My Profile'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (context, value, child) {
                return Icon(
                  value.visible ? Icons.clear : Icons.menu,
                  color: Colors.blue[900],
                );
              },
            ),
          ),
        ),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Information",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 4,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ]),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(photo),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              AutoSizeText(
                                _userController.userData.value.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                              AutoSizeText(
                                _userController.userData.value.phoneNumber ??
                                    "",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              AutoSizeText(
                                _locationController.userAddress.value,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Payment Method",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 50.vh,
                        width: 90.vw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.blue,
                          //     blurRadius: 4,
                          //     offset: Offset(4, 8), // Shadow position
                          //   ),
                          // ]
                        ),
                        child: SingleChildScrollView(
                                                  child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                onTap: () =>
                                    _appController.changeToCardPaymentMethod(),
                                leading: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Colors.blue),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: _appController.cardPaymentMethod.value
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
                                title: Row(
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Icon(Icons.credit_card,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 11),
                                    AutoSizeText(
                                      "Card",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              ListTile(
                                onTap: () =>
                                    _appController.changeToBankPaymentMethod(),
                                leading: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Colors.blue),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: _appController.bankPaymentMethod.value
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
                                title: Row(
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Icon(Icons.home_work_rounded,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 11),
                                    AutoSizeText(
                                      "Bank Account",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                onTap: () =>
                                    _appController.changeToPaypalPaymentMethod(),
                                leading: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Colors.blue),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:
                                        _appController.paypalPaymentMethod.value
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
                                title: Row(
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Icon(LineIcons.paypal,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 11),
                                    AutoSizeText(
                                      "Paypal",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                onTap: () =>
                                    _appController.changeToCashPaymentMethod(),
                                leading: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Colors.blue),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: _appController.cashPaymentMethod.value
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
                                title: Row(
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Icon(LineIcons.moneyBill,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 11),
                                    AutoSizeText(
                                      "Cash",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    logo,
                  ),
                ),
                ListTile(
                  onTap: () => Get.off(HomeScreen()),
                  leading: Icon(LineIcons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () => Get.off(ProfileScreen()),
                  leading: Icon(LineIcons.user),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () => Get.off(History()),
                  leading: Icon(LineIcons.history),
                  title: Text('History'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(LineIcons.newspaper),
                  title: Text('Privacy Policy'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Security'),
                ),
                ListTile(
                  onTap: () {
                    _userController.signOut();
                  },
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: AutoSizeText('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
