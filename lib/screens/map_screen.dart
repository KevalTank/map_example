import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_example/bloc/airport/map_bloc.dart';
import 'package:map_example/constants/map_constants.dart';
import 'package:map_example/models/airport_model.dart';

// Actual map screen the map will shown here
class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  // Creating hte marker for the map
  Set<Marker> _createMarker({required AirportModel airportModel}) {
    // Getting latitude and longitude from the airport model
    final lat = getLatLongFromString(latOrLong: airportModel.lat);
    final lon = getLatLongFromString(latOrLong: (airportModel.lon));
    return {
      // Will create a marker where,
      // markerId: Marker's unique id
      // position: Actual location where marker bing shown
      // infoWindow: It will show info of the airport when user taps on the marker
      Marker(
        markerId: MarkerId(airportModel.icao),
        position: LatLng(lat, lon),
        infoWindow: InfoWindow(
          title: airportModel.name,
          snippet:
              '${airportModel.city}, ${airportModel.state},${airportModel.country},${airportModel.lat},${airportModel.lon}',
        ),
      ),
    };
  }

  // This will convert the latitude and longitude from the string to double
  double getLatLongFromString({required String latOrLong}) =>
      double.tryParse(latOrLong) ?? 19.018255973653343;

  @override
  Widget build(BuildContext context) {
    // To prevent user can't get back with the gestures
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps Demo'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Resetting map bloc and navigating to the previous(list of maps) screen
              context.read<MapBloc>().add(ResetMapRequested());
              Navigator.of(context).pop();
            },
          ),
        ),
        body: BlocBuilder<MapBloc, MapState>(
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.airportModel != current.airportModel,
          builder: (context, state) {
            final lat =
                getLatLongFromString(latOrLong: state.airportModel!.lat);
            final log =
                getLatLongFromString(latOrLong: state.airportModel!.lon);
            // Actual map will build here
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, log),
                zoom: MapConstants.mapZoom,
                tilt: MapConstants.tilt,
                bearing: MapConstants.bearing,
              ),
              markers: _createMarker(airportModel: state.airportModel!),
            );
          },
        ),
      ),
    );
  }
}
