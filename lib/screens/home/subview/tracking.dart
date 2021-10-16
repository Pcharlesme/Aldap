import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_dee/models/history.dart';
import 'package:delivery_dee/screens/home/pageview/widgets/containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:timeline_node/timeline_node.dart';

class Tracking extends StatelessWidget {
  final List<HistoryModel> timelineObject = [
    HistoryModel(
        message: 'Shipping Received',
        subtitle: '20-3-2021, 14:37pm',
        style: TimelineNodeStyle(lineType: TimelineNodeLineType.BottomHalf)),
    HistoryModel(
        message: "Shipping Pickup",
         subtitle: '16-3-2021, 4:40pm',
        style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.Full, lineColor: Colors.red)),
    HistoryModel(
        message: "Delivery",
         subtitle: '3-2-2021, 1:00pm',
        style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.TopHalf, lineColor: Colors.green)),
  ];

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
          "Tracking",
          style: TextStyle(color: Colors.blue[900]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
                  child: Column(
            children: [
              TrackViewContainer(
                code: "798",
                from: "2715 Ash Dr. San Jose, South Dakota",
                shipping: "4140 Parker Rd. AlienTown, NewMexico",
                weight: "2.7kg",
                cost: "500",
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText("History",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                height: 40.vh,
                child: ListView.builder(
                    itemCount: timelineObject.length,
                    itemBuilder: (context, index) {
                      return TimelineNode(
                        style: timelineObject[index].style,
                        indicator: SizedBox(
                          width: 10,
                          height: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(timelineObject[index].message),
                                  SizedBox(height: 8),
                                  Text(timelineObject[index].subtitle),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
