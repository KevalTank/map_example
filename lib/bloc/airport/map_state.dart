part of 'map_bloc.dart';

// Actual state that hold the data
class MapState extends Equatable {
  const MapState({
    this.status = Status.initial,
    this.listOfAirports = const [],
    this.airportModel,
    this.mapLoaded = false,
    this.errorMessage = '',
  });

  final Status status;
  final List<AirportModel> listOfAirports;
  final AirportModel? airportModel;
  final bool mapLoaded;
  final String errorMessage;

  MapState copyWith({
    Status? status,
    List<AirportModel>? listOfAirports,
    AirportModel? airportModel,
    bool? mapLoaded,
    String? errorMessage,
  }) {
    return MapState(
      status: status ?? this.status,
      listOfAirports: listOfAirports ?? this.listOfAirports,
      airportModel: airportModel ?? this.airportModel,
      mapLoaded: mapLoaded ?? this.mapLoaded,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props =>
      [
        status,
        listOfAirports,
        airportModel ?? AirportModel.defaultAirportModel,
        mapLoaded,
        errorMessage,
      ];
}
