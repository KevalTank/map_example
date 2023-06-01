import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:map_example/constants/shared_preference_constants.dart';
import 'package:map_example/models/airport_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Shared preference singleton helper class that
// stores data into the preferences
class SharedPrefHelper {
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();

  SharedPrefHelper._internal() {
    _initPrefs();
  }

  factory SharedPrefHelper() {
    return _instance;
  }

  SharedPreferences? _prefs;

  // List that will hold the list of airports
  late final List<AirportModel> _airportList = [];

  // Initializing the preferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Storing list of airports to the preferences
  Future<bool> saveAirportsToSharedPreferences({
    required List<AirportModel> listOfAirportModel,
  }) async {
    _airportList.addAll(listOfAirportModel);
    bool saved = await _saveAirports();
    return saved;
  }

  // This will convert the list of the list of airports to the json format
  // Encode that list and save to the preferences
  Future<bool> _saveAirports() async {
    if (_prefs == null) {
      await _initPrefs();
    }
    final airportJsonList = _airportList.map((airport) => airport.toJson()).toList();
    final airportStringList = airportJsonList.map((json) => jsonEncode(json)).toList();
    var saved = await _prefs!.setStringList(SharedPrefConstants.keyAirports, airportStringList);
    if(saved){
      debugPrint('Saved successfully!!!');
      return true;
    }
    else{
      debugPrint('Oops! Something went wrong while saving data to shared preferences!!!!');
      return false;
    }
  }

  // This will check in the preferences that list of airports in string list is present or not?
  // If present then it will decode and convert it to the model it and will return
  Future<List<AirportModel>> getStoredAirportsFromSharedPreferences() async {
    if (_prefs == null) {
      await _initPrefs();
    }
    final airportStringList = _prefs!.getStringList(SharedPrefConstants.keyAirports);
    if (airportStringList != null) {
      final airportJsonList = airportStringList.map((string) => jsonDecode(string)).toList();
      return airportJsonList.map((json) => AirportModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
