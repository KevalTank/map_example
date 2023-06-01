import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_example/constants/status.dart';
import 'package:map_example/local_storage/shared_preference_helper.dart';
import 'package:map_example/models/airport_model.dart';
import 'package:map_example/repository/app_repository.dart';

part 'map_event.dart';

part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({
    required AppRepository appRepository,
    required SharedPrefHelper helper,
  })  : _appRepository = appRepository,
        _helper = helper,
        super(const MapState()) {
    on<LoadAirportsRequested>(_onLoadAirportsRequested);
    on<LoadMapRequested>(_onLoadMapRequested);
    on<ResetMapRequested>(_onResetMapRequested);
  }

  final AppRepository _appRepository;
  final SharedPrefHelper _helper;

  FutureOr<void> _onLoadAirportsRequested(
    LoadAirportsRequested event,
    Emitter<MapState> emit,
  ) async {
    // Put state inProgress
    emit(state.copyWith(status: Status.inProgress));
    // Check if airports are available in shared preferences?
    var listOfAirportsFromPreferences =
        await _helper.getStoredAirportsFromSharedPreferences();
    // If list of airports are not available then it will call the API
    if (listOfAirportsFromPreferences.isEmpty) {
      var listOfAirports = await _appRepository.getAllAirports();
      if (listOfAirports.isNotEmpty) {
        // Storing list of airports to the shared preferences.
        bool saved = await _helper.saveAirportsToSharedPreferences(
            listOfAirportModel: listOfAirports);
        if (!saved) {
          debugPrint(
              'Something went wrong while saving list of airports to the preferences, API will call again');
        }
        // Put state in success
        emit(
          state.copyWith(
            status: Status.success,
            listOfAirports: listOfAirports,
          ),
        );
      } else {
        // Managed state for API failure
        emit(
          state.copyWith(
            status: Status.failure,
            errorMessage: 'Something went wrong while fetching all airports',
          ),
        );
      }
    } else {
      // If list of airports form shared preferences are not empty
      emit(
        state.copyWith(
          status: Status.success,
          listOfAirports: listOfAirportsFromPreferences,
        ),
      );
    }
  }

  FutureOr<void> _onLoadMapRequested(
    LoadMapRequested event,
    Emitter<MapState> emit,
  ) async {
    // Put state inProgress
    emit(state.copyWith(status: Status.inProgress));
    // Passing the airport model to the UI
    emit(
      state.copyWith(
        status: Status.success,
        airportModel: event.airportModel,
        mapLoaded: true,
      ),
    );
  }

  FutureOr<void> _onResetMapRequested(
    ResetMapRequested event,
    Emitter<MapState> emit,
  ) {
    // Resetting the airport model when user taps on the back screen
    emit(
      state.copyWith(
        airportModel: null,
        mapLoaded: false,
      ),
    );
  }
}
