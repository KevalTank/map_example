import 'package:flutter/material.dart';
import 'package:map_example/initializer.dart';
import 'package:map_example/map_example.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // This will configure the external dependencies
  await configureDependencies();
  runApp(const MapExample());
}
