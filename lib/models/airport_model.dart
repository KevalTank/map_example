// Actual airport model
class AirportModel {
  const AirportModel({
    required this.icao,
    this.iata,
    required this.name,
    required this.city,
    required this.state,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tz,
  });

  final String icao;
  final String? iata;
  final String name;
  final String city;
  final String state;
  final String country;
  final String lat;
  final String lon;
  final String tz;

  Map<String, dynamic> toJson() {
    return {
      'icao': icao,
      'iata': iata,
      'name': name,
      'city': city,
      'state': state,
      'country': country,
      'lat': lat,
      'lon': lon,
      'tz': tz,
    };
  }

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    final icao = checkWeatherFieldIsNull(val: json['icao']);
    final iata = checkWeatherFieldIsNull(val: json['iata']);
    final name = checkWeatherFieldIsNull(val: json['name']);
    final city = checkWeatherFieldIsNull(val: json['city']);
    final state = checkWeatherFieldIsNull(val: json['state']);
    final country = checkWeatherFieldIsNull(val: json['country']);
    final lat = checkWeatherFieldIsLatOrLon(val: json['lat']);
    final lon = checkWeatherFieldIsLatOrLon(val: json['lon']);
    final tz = checkWeatherFieldIsNull(val: json['tz']);
    return AirportModel(
      icao: icao,
      iata: iata,
      name: name,
      city: city,
      state: state,
      country: country,
      lat: lat,
      lon: lon,
      tz: tz,
    );
  }

  static String checkWeatherFieldIsNull({required dynamic val}) {
    if (val == null || val.toString().isEmpty) {
      return '0.0';
    } else {
      return val.toString();
    }
  }

  static String checkWeatherFieldIsLatOrLon({required dynamic val}) {
    if (val == null || val.runtimeType == null) {
      return '0.0';
    } else if (val.runtimeType == int || val.runtimeType == double) {
      return val.toString();
    } else {
      return val.toString();
    }
  }

  static convertAirportResponseToModel(Map<String, dynamic> json) =>
      AirportModel.fromJson(json);

  static AirportModel defaultAirportModel = const AirportModel(
    icao: '00AK',
    iata: '',
    name: 'Lowell Field',
    city: 'Anchor Point',
    state: 'Alaska',
    country: 'US',
    lat: '59.94919968',
    lon: '-151.695999146',
    tz: 'America\/Anchorage',
  );
}
