import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/controllers/location_controller.dart';
import 'package:delivery_dee/screens/home/subview/map_page.dart';
import 'package:delivery_dee/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class Location extends StatelessWidget {
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
        title: AutoSizeText(
          "Location",
          style: TextStyle(color: Colors.blue[900]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
                  child: Column(
            children: [
              SizedBox(height: 20.h),
              Image.asset(location),
              SizedBox(height: 20.h),
              AutoSizeText(
                "No history yet",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: AutoSizeText("Address",
                        style: TextStyle(color: Colors.blueGrey)),
                    subtitle: AutoSizeText(_locationController.userAddress.value,
                        style: TextStyle(color: Colors.blueGrey)),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(text: "Next", onTap: () => Get.to(MapPage())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
