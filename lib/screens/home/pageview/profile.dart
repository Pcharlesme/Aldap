import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/controllers/user_controllers.dart';
import 'package:delivery_dee/screens/home/pageview/home.dart';
import 'package:delivery_dee/widgets/custom_button.dart';
import 'package:delivery_dee/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:resize/resize.dart';

class ProfileScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  validateAndSubmit(context) {
    if (_validateAndSave()) {
      showLoading();
      try {
        Map<String, dynamic> updateData = {
          "phoneNumber": _userController.phoneNoTextEditingController.text,
          "username": _userController.usernameTextEditingController.text,
          "name": _userController.fullnameTextEditingController.text
        };
        _userController.updateUserDataDb(updateData);
        dismissLoading();
        AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            title: 'Succes',
            desc: 'Yeay. Your Profile updated',
            btnOkOnPress: () {},
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: () => Get.back())
          ..show();
      } catch (e) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: 'Error',
            desc: 'Unable to update your data',
            btnOkOnPress: () => Get.back(),
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
          ..show();
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // _userController.phoneNoTextEditingController.text =
    //     _userController.userData.value.phoneNumber ?? '';
    // _userController.fullnameTextEditingController.text =
    //     _userController.userData.value.name;
    // _userController.emailTextEditingController.text =
    //     _userController.userData.value.email;
    // _userController.usernameTextEditingController.text =
    //     _userController.userData.value.username;
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
          child: Form(
            key: _formKey,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(logo),
                    SizedBox(height: 25),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: _userController.phoneNoTextEditingController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.mobile_friendly),
                          hintText: "Phone Number"),
                    ),
                    SizedBox(height: 25.h),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: _userController.fullnameTextEditingController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.perm_contact_cal_outlined),
                          hintText: "Full name"),
                    ),
                    SizedBox(height: 25.h),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: _userController.emailTextEditingController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.attach_email),
                          hintText: "Email Address"),
                    ),
                    SizedBox(height: 25.h),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: _userController.usernameTextEditingController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.mobile_friendly),
                          hintText: "Username"),
                    ),
                    SizedBox(height: 30.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                          text: "Edit Profile",
                          onTap: () {
                            validateAndSubmit(context);
                          }),
                    ),
                  ],
                ),
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
