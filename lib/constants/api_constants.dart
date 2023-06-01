// API related constants
class ApiConstants {
  ApiConstants._();

  static const baseUrl = 'https://raw.githubusercontent.com';

  static const defaultConnectTimeout = Duration(seconds: 60);
  static const defaultReceiveTimeout = Duration(seconds: 60);

  static const airport = '/mwgg/Airports/master/airports.json';
}
