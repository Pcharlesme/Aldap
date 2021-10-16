import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/controllers/app_controller.dart';
import 'package:delivery_dee/screens/home/pageview/widgets/containers.dart';
import 'package:delivery_dee/screens/home/pageview/widgets/service_container.dart';
import 'package:delivery_dee/screens/home/subview/local_intro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class Courier extends StatelessWidget {
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
          "Courier",
          style: TextStyle(color: Colors.blue[900]),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
                      child: Column(
              children: [
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText("What are you sending?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp)),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _appController.changetoAccessoriesContainer(),
                      child: PackageContainer(
                        color: _appController.accessoriesSendingType.value
                            ? Colors.blue[900]
                            : Colors.grey[200],
                        image: p1,
                        text: "Accessories",
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _appController.changetoGiftContainer(),
                      child: PackageContainer(
                        color: _appController.giftSendingType.value
                            ? Colors.blue[900]
                            : Colors.grey[200],
                        image: p2,
                        text: "Gift",
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _appController.changetoOthersContainer(),
                      child: PackageContainer(
                        color: _appController.othersSendingType.value
                            ? Colors.blue[900]
                            : Colors.grey[200],
                        image: p3,
                        text: "Others",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText("Enter weight",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp)),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: _appController.weightController.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        hintText: "Enter Weight",
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    )),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        _appController.changeWeightContainer();
                        // _appController.weightController.value.text =
                        //     _appController.weightController.value.text + "kg";
                      },
                      child: AnimatedContainer(
                        height: 50.h,
                        width: 50.h,
                        duration: Duration(seconds: 1),
                        decoration: BoxDecoration(
                            color: _appController.kgWeight.value
                                ? Colors.blue[900]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: AutoSizeText("kg",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _appController.kgWeight.value
                                      ? Colors.white
                                      : Colors.black,
                                ))),
                      ),
                    ),
                    SizedBox(width: 5),
                    //Spacer(),
                    GestureDetector(
                      onTap: () {
                        _appController.changeWeightContainer();
                        // _appController.weightController.value.text =
                        //     _appController.weightController.value.text + "lbs";
                      },
                      child: AnimatedContainer(
                        height: 50.h,
                        width: 50.h,
                        duration: Duration(seconds: 1),
                        decoration: BoxDecoration(
                            color: _appController.lbsWeight.value
                                ? Colors.blue[900]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: AutoSizeText("lbs",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _appController.lbsWeight.value
                                      ? Colors.white
                                      : Colors.black,
                                ))),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText("Deliver Type",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      )),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ServiceContainer(image: express, text: "express"),
                    GestureDetector(
                        onTap: () => Get.to(LocalIntro()),
                        child: ServiceContainer(image: local, text: "local")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
