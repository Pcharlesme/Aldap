import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

// const GOOGLE_MAPS_API_KEY = "AIzaSyBqUAHYRrjzyAhJ3AB5rqDNkd8ltot_pts";
const GOOGLE_MAPS_API_KEY = "AIzaSyBcnKoE4md3p1qjEb27u3H_wI9I5gpr5Os";

GoogleMapsPlaces places = GoogleMapsPlaces(
  apiKey: GOOGLE_MAPS_API_KEY,
  //apiHeaders: GoogleApiHeaders().getHeaders(),
);

place() async {
  GoogleMapsPlaces places = GoogleMapsPlaces(
    apiKey: GOOGLE_MAPS_API_KEY,
    apiHeaders: await GoogleApiHeaders().getHeaders(),
  );
  return places;
}
