import 'package:delivery_dee/constants/map.dart';
import 'package:delivery_dee/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class PickupSelectionWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  const PickupSelectionWidget({Key key, this.scaffoldState}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LocationController _locationController = Get.find();
    final box = GetStorage();
    return Obx(() => DraggableScrollableSheet(
          initialChildSize: 0.28,
          minChildSize: 0.28,
          builder: (BuildContext context, myscrollController) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.8),
                        offset: Offset(3, 2),
                        blurRadius: 7)
                  ]),
              child: ListView(
                controller: myscrollController,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Move the pin to adjust pickup location",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Container(
                      color: Colors.grey.withOpacity(.3),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        child: TextField(
                          onTap: () async {
                            print(
                                "=======================here=======================");

                            Prediction p = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: GOOGLE_MAPS_API_KEY,
                                mode: Mode.overlay, // Mode.fullscreen
                                language: "en",
                                components: [
                                  new Component(
                                      Component.country, box.read("country"))
                                ]);
                            PlacesDetailsResponse detail =
                                await places.getDetailsByPlaceId(p.placeId);
                            double lat = detail.result.geometry.location.lat;
                            double lng = detail.result.geometry.location.lng;
                            _locationController.changeRequestedDestination(
                                reqDestination: p.description,
                                lat: lat,
                                lng: lng);
                            _locationController.updateDestination(
                                destination: p.description);
                            LatLng coordinates = LatLng(lat, lng);
                            _locationController.setPickCoordinates(
                                coordinates: coordinates);
                            _locationController.changePickupLocationAddress(
                                address: p.description);
                          },
                          textInputAction: TextInputAction.go,
                          controller: _locationController.pickupLocationController,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20, bottom: 15),
                              width: 10,
                              height: 10,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Where are you",
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
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor,
                          elevation: 7.0,
                          child: ElevatedButton(
                            onPressed: () async {
                              await _locationController.sendRequest();
                              _locationController.changeWidgetShowed(
                                  showWidget: Show.ConfirmDetails);
                            },
                            child: Text(
                              "Confirm Location",
                              style: TextStyle(
                                fontFamily: 'Brand Bold',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
