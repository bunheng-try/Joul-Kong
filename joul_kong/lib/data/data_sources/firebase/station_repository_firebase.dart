import 'dart:convert';
import 'package:http/http.dart' as http;
import '/data/dtos/station_dto.dart';
import '/data/repositories/station/station_repository.dart';
import '/models/station.dart';
import 'dart:math';

class FirebaseStationRepository implements StationRepository {
  final String baseUrl;

  FirebaseStationRepository(this.baseUrl);

  @override
  Future<List<Station>> getStations() async {
    final url = Uri.parse('$baseUrl/stations.json');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch stations");
    }

    final data = jsonDecode(response.body);

    if (data == null) return [];

    final Map<String, dynamic> map = data;

    return map.entries.map((entry) {
      return StationDto.fromJson(entry.key, entry.value).toDomain();
    }).toList();
  }

  @override
  Future<Station> getStationById(String stationId) async {
    final url = Uri.parse('$baseUrl/stations/$stationId.json');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch station");
    }

    final data = jsonDecode(response.body);

    if (data == null) {
      throw Exception("Station not found");
    }

    return StationDto.fromJson(stationId, data).toDomain();
  }

  @override
  Future<List<Station>> searchStations(String query) async {
    final stations = await getStations();

    return stations.where((station) {
      return station.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Future<List<Station>> getNearbyStations({
    required double latitude,
    required double longitude,
  }) async {
    const radiusKm = 5.0;

    final stations = await getStations();

    final nearby = stations.where((station) {
      final distance = _calculateDistance(
        userLatitude: latitude,
        userLongitude: longitude,
        stationLatitude: station.latitude,
        stationLongitude: station.longitude,
      );

      return distance <= radiusKm;
    }).toList();

    nearby.sort((a, b) {
      final distA = _calculateDistance(
        userLatitude: latitude,
        userLongitude: longitude,
        stationLatitude: a.latitude,
        stationLongitude: a.longitude,
      );

      final distB = _calculateDistance(
        userLatitude: latitude,
        userLongitude: longitude,
        stationLatitude: b.latitude,
        stationLongitude: b.longitude,
      );

      return distA.compareTo(distB);
    });

    return nearby;
  }

  double _calculateDistance({
    required double userLatitude,
    required double userLongitude,
    required double stationLatitude,
    required double stationLongitude,
  }) {
    const earthRadius = 6371;

    double toRadians(double degree) => degree * pi / 180;

    final dLat = toRadians(stationLatitude - userLatitude);
    final dLon = toRadians(stationLongitude - userLongitude);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(toRadians(userLatitude)) *
            cos(toRadians(stationLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }
}
