import 'package:delivery_dee/constants/assets_path.dart';
import 'package:delivery_dee/models/map_route.dart';
import 'package:delivery_dee/services/google_request.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class LocationController extends GetxController {
  static LocationController instance = Get.find();
  RxString userLocation = "".obs;
  RxString userAddress = "".obs;
  Position _currentPosition;
  final box = GetStorage();
  TextEditingController destinationController = TextEditingController();
  TextEditingController pickupLocationController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    _getCurrentLocation();
    _setCustomMapPin();
    _getUserLocation();
  }

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      print(_currentPosition);
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      userAddress.value = "${place.locality}, ${place.country}";
      print(userAddress.value);
    } catch (e) {
      print(e);
    }
  }

  // Everything that has to do with the map
  static const PICKUP_MARKER_ID = 'pickup';
  static const LOCATION_MARKER_ID = 'location';
  GoogleMapController googleMapController;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  static Rx<LatLng> _center = LatLng(0, 0).obs;
  Position position;
  Set<Marker> _markers = {};
  //  this polys will be displayed on the map
  Set<Polyline> _poly = {};
  // this polys temporarely store the polys to destination
  // ignore: unused_field
  Set<Polyline> _routeToDestinationPolys = {};
  Rx<Show> show = Show.DESTINATION_SELECTION.obs;
  RxInt timeCounter = 0.obs;
  RxDouble percentage = 0.0.obs;
  RxString requestedDestination = "".obs;

  RxString requestStatus = "".obs;
  RxDouble requestedDestinationLat = 0.0.obs;

  RxDouble requestedDestinationLng = 0.0.obs;

  Rx<LatLng> pickupCoordinates = LatLng(0, 0).obs;
  Rx<LatLng> destinationCoordinates = LatLng(0, 0).obs;
  Rx<double> ridePrice = 0.0.obs;
  RouteModel routeModel;
  // ignore: unused_field
  LatLng _lastPosition = _center.value;

  LatLng get center => _center.value;
  Set<Marker> get markers => _markers;
  Set<Polyline> get poly => _poly;

  //   taxi pin
  BitmapDescriptor carPin;

  //   location pin
  BitmapDescriptor locationPin;

  _setCustomMapPin() async {
    carPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), car);

    locationPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), pin);
  }

  Future<Position> _getUserLocation() async {
    position = await Geolocator.getCurrentPosition();
    print(
        "==============================>${position.latitude}, ${position.longitude}");

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (box.read('country') == null) {
      String country = placemark[0].isoCountryCode.toLowerCase();
      box.write('country', country);
    }

    _center.value = LatLng(position.latitude, position.longitude);
    print(
        "=========passed==center===================>${_center.value.latitude}, ${_center.value.longitude}");
    return position;
  }

  changeRequestedDestination({String reqDestination, double lat, double lng}) {
    requestedDestination.value = reqDestination;
    requestedDestinationLat.value = lat;
    requestedDestinationLng.value = lng;
    print("===========change requested destination==========");
    print(requestedDestination.value);
    print(requestedDestinationLat.value);
    print(requestedDestinationLng.value);
  }

  void updateDestination({String destination}) {
    destinationController.text = destination;
    print("===========update destination==========");
    print(destinationController.text);
  }

  setDestination({LatLng coordinates}) {
    destinationCoordinates.value = coordinates;
    print("===========set destination==========");
    print(destinationCoordinates.value);
  }

  setPickCoordinates({LatLng coordinates}) {
    pickupCoordinates.value = coordinates;
    print("===========set pick up coordinates==========");
    print(pickupCoordinates.value);
  }

  addPickupMarker(LatLng position) {
    if (pickupCoordinates == null) {
      pickupCoordinates.value = position;
      print("===========add pickup marker==========");
      print(pickupCoordinates.value);
    }
    _markers.add(Marker(
        markerId: MarkerId(PICKUP_MARKER_ID),
        position: position,
        anchor: Offset(0, 0.85),
        zIndex: 3,
        infoWindow: InfoWindow(title: "YOU", snippet: "Your location"),
        icon: locationPin));
  }

  changePickupLocationAddress({String address}) async {
    pickupLocationController.text = address;
    if (pickupCoordinates != null) {
      _center = pickupCoordinates;
    }
  }

  changeWidgetShowed({Show showWidget}) {
    show.value = showWidget;
    print("Change Widget");
  }

  // ANCHOR: MARKERS AND POLYS
  _addLocationMarker(LatLng position, String distance) {
    _markers.add(Marker(
        markerId: MarkerId(LOCATION_MARKER_ID),
        position: position,
        anchor: Offset(0, 0.85),
        infoWindow:
            InfoWindow(title: destinationController.text, snippet: distance),
        icon: locationPin));
  }

  List<LatLng> _convertToLatLong(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  clearPoly() {
    _poly.clear();
  }

  _createRoute(String decodeRoute, {Color color}) {
    clearPoly();
    var uuid = new Uuid();
    String polyId = uuid.v1();
    _poly.add(Polyline(
        polylineId: PolylineId(polyId),
        width: 12,
        color: color ?? Colors.blue,
        onTap: () {},
        points: _convertToLatLong(_decodePoly(decodeRoute))));
  }

  Future sendRequest({LatLng origin, LatLng destination}) async {
    LatLng _org;
    LatLng _dest;

    if (origin == null && destination == null) {
      _org = pickupCoordinates.value;
      _dest = destinationCoordinates.value;
    } else {
      _org = origin;
      _dest = destination;
    }

    RouteModel route =
        await _googleMapsServices.getRouteByCoordinates(_org, _dest);
    routeModel = route;

    if (origin == null) {
      ridePrice.value =
          double.parse((routeModel.distance.value / 500).toStringAsFixed(2));
    }
    List<Marker> mks = _markers
        .where((element) => element.markerId.value == "location")
        .toList();
    if (mks.length >= 1) {
      _markers.remove(mks[0]);
    }
// ! another method will be created just to draw the polys and add markers
    _addLocationMarker(destinationCoordinates.value, routeModel.distance.text);
    _center = destinationCoordinates;
    if (_poly != null) {
      _createRoute(route.points, color: Colors.blue);
    }
    _createRoute(
      route.points,
    );
    _routeToDestinationPolys = _poly;
  }

  onCameraMove(CameraPosition position) {
    //  MOVE the pickup marker only when selecting the pickup location
    if (show.value == Show.PICKUP_SELECTION) {
      _lastPosition = position.target;
      changePickupLocationAddress(address: "loading...");
      if (_markers.isNotEmpty) {
        _markers.forEach((element) async {
          if (element.markerId.value == PICKUP_MARKER_ID) {
            _markers.remove(element);
            pickupCoordinates.value = position.target;
            addPickupMarker(position.target);
            List<Placemark> placemark = await placemarkFromCoordinates(
                position.target.latitude, position.target.longitude);
            pickupLocationController.text = placemark[0].name;
          }
        });
      }
    }
  }
}

// * THIS ENUM WILL CONTAIN THE DRAGGABLE WIDGET TO BE DISPLAYED ON THE MAIN SCREEN
enum Show {
  DESTINATION_SELECTION,
  PICKUP_SELECTION,
  ConfirmDetails,
  PAYMENT_METHOD_SELECTION,
  DRIVER_FOUND,
  TRIP
}
