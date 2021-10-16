import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_dee/constants/map.dart';
import 'package:delivery_dee/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class DestinationSelectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocationController _locationController = Get.find();
    final box = GetStorage();
    return DraggableScrollableSheet(
      initialChildSize: 0.28,
      minChildSize: 0.28,
      builder: (BuildContext context, myscrollController) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.8),
                    offset: Offset(3, 2),
                    blurRadius: 7)
              ]),
          child: ListView(
            controller: myscrollController,
            children: [
              Icon(
                Icons.remove,
                size: 50,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Container(
                  color: Colors.grey.withOpacity(.3),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: TextField(
                      onTap: () async {
                        print("==========country====${box.read("country")}");
                        Prediction p = await PlacesAutocomplete.show(
                            // types: [],
                            // strictbounds: false,
                            context: context,
                            apiKey: "AIzaSyBqUAHYRrjzyAhJ3AB5rqDNkd8ltot_pts",

                            //apiKey: "AIzaSyBcnKoE4md3p1qjEb27u3H_wI9I5gpr5Os",
                            mode: Mode.overlay, // Mode.fullscreen
                            language: "en",
                            components: [
                              new Component(
                                  Component.country, box.read("country"))
                            ]);
                        print("=================placeId $p ================");
                        if (p != null) {
                          print("================not null ================");
                          print(p.placeId);
                          PlacesDetailsResponse detail =
                              await place().getDetailsByPlaceId(p.placeId);
                          double lat = detail.result.geometry.location.lat;
                          double lng = detail.result.geometry.location.lng;
                          _locationController.changeRequestedDestination(
                              reqDestination: p.description,
                              lat: lat,
                              lng: lng);
                          _locationController.updateDestination(
                              destination: p.description);
                          LatLng coordinates = LatLng(lat, lng);
                          _locationController.setDestination(
                              coordinates: coordinates);
                          _locationController
                              .addPickupMarker(_locationController.center);
                          _locationController.changeWidgetShowed(
                              showWidget: Show.PICKUP_SELECTION);
                          //_locationController.sendRequest(coordinates: coordinates);
                        }else{
                          print("================PlacesAutocomplete.show is null ================");
                        }
                      },
                      textInputAction: TextInputAction.go,
                      controller: _locationController.destinationController,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20, bottom: 15),
                          width: 10,
                          height: 10,
                          child: Icon(Icons.search,
                              color: Theme.of(context).primaryColor),
                        ),
                        hintText: "Where are you going to?",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MiddleDestination extends StatelessWidget {
  final LocationController _locationController = Get.find();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: GestureDetector(
        onTap: () async {
          print("==========country====${box.read("country")}");
          Prediction p = await PlacesAutocomplete.show(
              // types: [],
              // strictbounds: false,
              context: context,
              apiKey: "AIzaSyBcnKoE4md3p1qjEb27u3H_wI9I5gpr5Os",

              //apiKey: "AIzaSyBcnKoE4md3p1qjEb27u3H_wI9I5gpr5Os",
              mode: Mode.overlay, // Mode.fullscreen
              language: "en",
              components: [
                new Component(Component.country, box.read("country"))
              ]);
          print("=================placeId================");
          if (p != null) {
            print(p.placeId);
            PlacesDetailsResponse detail =
                await places.getDetailsByPlaceId(p.placeId);
            double lat = detail.result.geometry.location.lat;
            double lng = detail.result.geometry.location.lng;
            _locationController.changeRequestedDestination(
                reqDestination: p.description, lat: lat, lng: lng);
            _locationController.updateDestination(destination: p.description);
            LatLng coordinates = LatLng(lat, lng);
            _locationController.setDestination(coordinates: coordinates);
            _locationController.addPickupMarker(_locationController.center);
            _locationController.changeWidgetShowed(
                showWidget: Show.PICKUP_SELECTION);
            //_locationController.sendRequest(coordinates: coordinates);
          }
        },
        child: Container(
          height: 60,
          margin: EdgeInsets.symmetric(vertical: 150, horizontal: 100),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.search),
              Expanded(
                  child: AutoSizeText(
                "Where are you going to",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
