import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/constants/firebase.dart';
import 'package:delivery_dee/controllers/app_controller.dart';
import 'package:delivery_dee/controllers/location_controller.dart';
import 'package:delivery_dee/controllers/user_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resize/resize.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AppController());
    Get.put(UserController());
    Get.put(LocationController());
  });
  await GetStorage.init();

  runApp(
    Resize(
      allowtextScaling: true,
      builder: () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Double Dee',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
        );
      },
    ),
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset(
              logo,
              width: 120,
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

