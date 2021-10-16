import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/controllers/location_controller.dart';
import 'package:delivery_dee/controllers/user_controllers.dart';
import 'package:delivery_dee/screens/home/pageview/no_history.dart';
import 'package:delivery_dee/screens/home/pageview/profile.dart';
import 'package:delivery_dee/screens/home/pageview/profile_details.dart';
import 'package:delivery_dee/screens/home/pageview/widgets/service_container.dart';
import 'package:delivery_dee/screens/home/pageview/widgets/containers.dart';
import 'package:delivery_dee/screens/home/subview/courier.dart';
import 'package:delivery_dee/screens/home/subview/shipment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:resize/resize.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController _userController = Get.find();
  final LocationController _locationController = Get.find();
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    var name = _userController.userData.value.name;
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
            actions: [
              GestureDetector(onTap: () {}, child: Image.asset(vr)),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          body: Obx(
            () => SingleChildScrollView(
                          child: Column(
                children: [
                  AutoSizeText(
                    name ?? "",
                    style: TextStyle(
                      fontSize: 24.sp,
                    ),
                  ),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.location_on, color: Colors.blue[900]),
                      label: AutoSizeText(
                        "Current Location",
                        style: TextStyle(color: Colors.grey),
                      )),
                  AutoSizeText(
                    _locationController.userAddress.value ?? "",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TrackContainer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "Services",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: AutoSizeText("See All",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Get.to(Courier()),
                          child:
                              ServiceContainer(image: courier, text: "Courier")),
                      GestureDetector(
                          onTap: () => Get.to(Shipment()),
                          child: ServiceContainer(
                              image: shipment, text: "Shipment")),
                    ],
                  ),
                ],
              ),
            ),
          )),
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
                  onTap: () => Get.off(ProfileScreen()),
                  leading: Icon(LineIcons.user),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () => Get.off(ProfileDetails()),
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Contact Address'),
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
