part of 'map_bloc.dart';

// Event file that will trigger the events
class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadAirportsRequested extends MapEvent {}

class LoadMapRequested extends MapEvent {
  const LoadMapRequested({
    required this.airportModel,
  });

  final AirportModel airportModel;
}

class ResetMapRequested extends MapEvent {}
