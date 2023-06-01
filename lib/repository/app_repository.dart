// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:map_example/constants/api_constants.dart';
import 'package:map_example/models/airport_model.dart';
import 'package:map_example/models/airport_model_json.dart';
import 'package:map_example/network/dio_http_service.dart';

part 'map_repository.dart';

// Main app repository
@singleton
class AppRepository {
  AppRepository(this._dioHttpService);

  final DioHttpService _dioHttpService;
}
