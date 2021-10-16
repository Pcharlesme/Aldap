import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/screens/home/subview/tracking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class TrackContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 50.vh,
      width: 80.vw,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          AutoSizeText(
            "Track your items",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            "Please enter your tracking number",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 2),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: "Enter tracking number",
              prefixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () => Get.to(Tracking())),
            ),
          ),
          Expanded(child: Image.asset(track)),
        ],
      ),
    );
  }
}

class TrackViewContainer extends StatelessWidget {
  final String shipping;
  final String cost;
  final String weight;
  final String code;
  final String from;

  const TrackViewContainer(
      {Key key, this.shipping, this.cost, this.weight, this.code, this.from})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 45.vh,
      width: 90.vw,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(
            title: AutoSizeText(
              "Code",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
            subtitle: AutoSizeText(
              code,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: AutoSizeText(
              "From",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
            subtitle: AutoSizeText(
              from,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: AutoSizeText(
              "Shipping",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
            subtitle: AutoSizeText(
              shipping,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    AutoSizeText(
                      "Weight",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                    SizedBox(height: 5),
                    AutoSizeText(
                      weight,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    AutoSizeText(
                      "Cost",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                    SizedBox(height: 5),
                    AutoSizeText(
                      "NGN $cost",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // ListTile(
                //   title: AutoSizeText(
                //     "Weight",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // subtitle: AutoSizeText(
                //   weight,
                //   style: TextStyle(
                //     color: Colors.white,
                //   ),
                // ),
                // ),
                // ListTile(
                //   title: AutoSizeText(
                //     "Cost",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   subtitle: AutoSizeText(
                //     "NGN $cost",
                //     style: TextStyle(
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PackageContainer extends StatelessWidget {
  final String image;
  final Color color;
  final String text;
  final Color textColor;

  const PackageContainer(
      {Key key, this.image, this.color, this.text, this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          height: 120.h,
          width: 80.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
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
