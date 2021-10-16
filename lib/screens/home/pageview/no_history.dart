import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/controllers/user_controllers.dart';
import 'package:delivery_dee/screens/home/pageview/home.dart';
import 'package:delivery_dee/screens/home/pageview/profile.dart';
import 'package:delivery_dee/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:resize/resize.dart';

class History extends StatelessWidget {
    final UserController _userController = Get.find();

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
          title: const Text(''),
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
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.electric_moped_rounded, color: Colors.grey, size: 100.h),
              SizedBox(height: 20.h),
              AutoSizeText(
                "No history yet",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              AutoSizeText(
                "Hit the button down below to create an order",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(text: "Start Now", onTap: () {}),
              ),
            ],
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
