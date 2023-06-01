import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_example/bloc/airport/map_bloc.dart';
import 'package:map_example/local_storage/shared_preference_helper.dart';
import 'package:map_example/repository/app_repository.dart';
import 'package:map_example/screens/home_screen.dart';

import 'initializer.dart';

class MapExample extends StatelessWidget {
  const MapExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Map bloc created here
    // It asks for Shared Preference's and App Repository's instance,So provided with getIt
    // And also made request for load airports
    // Here laze: false means when the bloc is created at that time it will call the 'LoadAirportsRequested'
    return BlocProvider(
      lazy: false,
      create: (context) => MapBloc(
        appRepository: getIt.get<AppRepository>(),
        helper: getIt.get<SharedPrefHelper>(),
      )..add(LoadAirportsRequested()),
      child: const MaterialApp(
        title: 'Map Example',
        home: HomeScreen(),
      ),
    );
  }
}
