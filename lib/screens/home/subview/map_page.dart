import 'package:delivery_dee/controllers/location_controller.dart';
import 'package:delivery_dee/screens/home/subview/map_widgets.dart/select_destination.dart';
import 'package:delivery_dee/screens/home/subview/map_widgets.dart/select_pickup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LocationController _locationController = Get.find();

  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var _initialCameraPosition = CameraPosition(
      target: _locationController.center,
      zoom: 15,
    );
    return Scaffold(
        body: Obx(
      () => Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            compassEnabled: true,
            rotateGesturesEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) =>
                _locationController.googleMapController = controller,
            markers: _locationController.markers,
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: MiddleDestination()),
          Positioned(
            top: 50,
            left: 15,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      )
                    ]),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.menu, color: Theme.of(context).primaryColor),
                    radius: 20.0),
              ),
            ),
          ),
          // ANCHOR Draggable
          Visibility(
            visible:
                _locationController.show.value == Show.DESTINATION_SELECTION,
            child: DestinationSelectionWidget(),
          ),

          Visibility(
            visible: _locationController.show.value == Show.PICKUP_SELECTION,
            child: PickupSelectionWidget(
              scaffoldState: scaffoldState,
            ),
          ),
        ],
      ),
    ));
  }
}
