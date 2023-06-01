import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_example/models/map/lat_lng.dart';

class MarkerModel {
  const MarkerModel({
    required this.markerId,
    required this.latLongPosition,
    required this.infoWindow,
  });

  final MarkerId markerId;
  final LatLong latLongPosition;
  final InfoWindow infoWindow;
}
