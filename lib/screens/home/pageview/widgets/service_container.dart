import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class ServiceContainer extends StatelessWidget {
  final String image;
  final String text;

  const ServiceContainer({Key key, this.image, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          height: 120.h,
          width: 120.h,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: Image.asset(image),
        ),
        SizedBox(height: 5.sp),
        AutoSizeText(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: Colors.black,
            )),
      ],
    );
  }
}
