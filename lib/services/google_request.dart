import 'dart:convert';

import 'package:delivery_dee/constants/map.dart';
import 'package:delivery_dee/models/map_route.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleMapsServices {
  Future<RouteModel> getRouteByCoordinates(LatLng l1, LatLng l2) async {
    String link =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$GOOGLE_MAPS_API_KEY";
    var url = Uri.parse(link);
    http.Response response = await http.get(url);
    print("===============directions status code==========");
    print(response.statusCode);
    Map values = jsonDecode(response.body);
    Map routes = values["routes"][0];
    Map legs = values["routes"][0]["legs"][0];
    RouteModel route = RouteModel(
        points: routes["overview_polyline"]["points"],
        distance: Distance.fromMap(legs['distance']),
        timeNeeded: TimeNeeded.fromMap(legs['duration']),
        endAddress: legs['end_address'],
        startAddress: legs['end_address']);
    return route;
  }
}
