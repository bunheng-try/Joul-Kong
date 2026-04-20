import 'package:joul_kong/data/data_sources/mock/mock_data.dart';
import 'package:joul_kong/data/repositories/station/station_repository.dart';
import 'package:joul_kong/models/station.dart';
import 'dart:math';

class MockStationRepository implements StationRepository {
  List<Station> get stations => MockData.stations;

  @override
  Future<List<Station>> getNearbyStations({
    required double latitude,
    required double longitude,
  }) async {
    const radiusKm = 5.0;

    List<Station> stations = this.stations;

    final nearbyStations = stations.where((station) {
      final distance = _calculateDistance(
        userLatitude: latitude,
        userLongitude: longitude,
        stationLatitude: station.latitude,
        stationLongitude: station.longitude,
      );
      return distance <= radiusKm;
    }).toList();

    nearbyStations.sort((station1, station2) {
      final distA = _calculateDistance(
        userLatitude: latitude,
        userLongitude: longitude,
        stationLatitude: station1.latitude,
        stationLongitude: station1.longitude,
      );
      final distB = _calculateDistance(
        userLatitude: latitude,
        userLongitude: longitude,
        stationLatitude: station2.latitude,
        stationLongitude: station2.longitude,
      );
      return distA.compareTo(distB);
    });

    return nearbyStations;
  }

  @override
  Future<Station> getStationById(String stationId) async {
    List<Station> stations = this.stations;

    return stations.firstWhere(
      (station) {
        return station.id == stationId;
      },
      orElse: () {
        throw Exception("Station With ID $stationId not found");
      },
    );
  }

  @override
  Future<List<Station>> getStations() async {
    await Future.delayed(Duration(seconds: 3));
    if (stations.isEmpty) {
      throw Exception("Stations is Empty");
    }

    return stations;
  }

  @override
  Future<List<Station>> searchStations(String query) async {
    List<Station> stations = this.stations;
    List<Station> searchStations = stations.where((station) {
      if (station.name.toLowerCase().contains(query.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    }).toList();
    return searchStations;
  }

  double _calculateDistance({
    required double userLatitude,
    required double userLongitude,
    required double stationLatitude,
    required double stationLongitude,
  }) {
    const earthRadius = 6371;

    double toRadians(double degree) => degree * pi / 180;

    final destinationLatitude = toRadians(stationLatitude - userLatitude);
    final destinationLongitude = toRadians(stationLongitude - userLongitude);

    final squareHalfChordLength =
        sin(destinationLatitude / 2) * sin(destinationLatitude / 2) +
            cos(toRadians(userLatitude)) *
            cos(toRadians(stationLatitude)) *
            sin(destinationLongitude / 2) *
            sin(destinationLongitude / 2);

    final centralAngle =
        2 * atan2(sqrt(squareHalfChordLength), sqrt(1 - squareHalfChordLength));

    return earthRadius * centralAngle;
  }
}
