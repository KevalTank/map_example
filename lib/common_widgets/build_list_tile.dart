import 'package:flutter/material.dart';
import 'package:map_example/models/airport_model.dart';

// This is common widget that will build
// when need to show the airport model in the UI
class BuildListTile extends StatelessWidget {
  const BuildListTile({
    Key? key,
    required this.mapModel,
  }) : super(key: key);

  final AirportModel mapModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(mapModel.name),
          Text(mapModel.icao),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${mapModel.city}, ${mapModel.state}'),
          Text(mapModel.country),
        ],
      ),
    );
  }
}
