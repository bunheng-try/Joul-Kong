import '/models/station.dart';

abstract class StationRepository {
  Future<List<Station>> getStations();
  Future<Station> getStationById(String stationId);
  Future<List<Station>> searchStations(String query);
  Future<List<Station>> getNearbyStations({
    required double latitude,
    required double longitude,
  });
}
