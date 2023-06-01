part of 'app_repository.dart';

// Map Repository (Feature based repository)
extension MapRepository on AppRepository {
  Future<List<AirportModel>> getAllAirports() async {
    try {
      final response = await _dioHttpService.get<String>(ApiConstants.airport);
      if (response?.isNotEmpty ?? false) {
        var responseList = buildAirportModelJsonListFromResponse(response!);
        return getAirportModelFromAirportModelJsonListFromResponse(
            airportModelJson: responseList);
      } else {
        debugPrint('Something went wrong while fetching airports from the API');
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
