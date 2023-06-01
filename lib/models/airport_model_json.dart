import 'dart:convert';

import 'package:map_example/models/airport_model.dart';

// Created this because key are not the same for the response
class AirportModelJson {
  AirportModelJson({
    required this.jsonKey,
    required this.airportModel,
  });

  String jsonKey;
  AirportModel airportModel;

  factory AirportModelJson.fromJson(MapEntry<String, dynamic> json) {
    return AirportModelJson(
      jsonKey: json.key,
      airportModel: AirportModel.fromJson(json.value),
    );
  }
}

List<AirportModelJson> buildAirportModelJsonListFromResponse(
  String response,
) {
  return (json.decode(response) as Map<String, dynamic>).entries.map(
    (json) {
      return AirportModelJson.fromJson(json);
    },
  ).toList();
}

List<AirportModel> getAirportModelFromAirportModelJsonListFromResponse({
  required List<AirportModelJson> airportModelJson,
}) {
  List<AirportModel> listOfAirports = [];
  for (int i = 0; i < airportModelJson.length; i++) {
    listOfAirports.add(airportModelJson[i].airportModel);
  }
  return listOfAirports;
}
