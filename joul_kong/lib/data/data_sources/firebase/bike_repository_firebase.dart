import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/data/dtos/bike_dto.dart';
import '/data/repositories/bike/bike_repository.dart';
import '/models/bike.dart';

class FirebaseBikeRepository implements BikeRepository {
  final String baseUrl;

  FirebaseBikeRepository(this.baseUrl);

  final Map<String, StreamController<List<Bike>>> _controllers = {};

  @override
  Stream<List<Bike>> watchBikesByStation(String stationId) {
    if (!_controllers.containsKey(stationId)) {
      _controllers[stationId] = StreamController<List<Bike>>.broadcast();

      _emit(stationId);
    }

    return _controllers[stationId]!.stream;
  }

  @override
  Future<List<Bike>> getBikesByStation(String stationId) async {
    final url = Uri.parse('$baseUrl/bikes.json');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch bikes");
    }

    final data = jsonDecode(response.body);

    if (data == null) return [];

    final Map<String, dynamic> map = data;

    final bikes = map.entries.map((entry) {
      return BikeDto.fromJson(entry.key, entry.value).toDomain();
    }).toList();

    return bikes.where((b) => b.currentStationId == stationId).toList();
  }

  @override
  Future<Bike?> getBikeById(String bikeId) async {
    final url = Uri.parse('$baseUrl/bikes/$bikeId.json');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body);

    if (data == null) return null;

    return BikeDto.fromJson(bikeId, data).toDomain();
  }

  @override
  Future<void> updateBike(Bike updatedBike) async {
    final url = Uri.parse('$baseUrl/bikes/${updatedBike.id}.json');

    final dto = BikeDto.fromDomain(updatedBike);

    final response = await http.patch(url, body: jsonEncode(dto.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to update bike");
    }

    if (updatedBike.currentStationId != null) {
      _emit(updatedBike.currentStationId!);
    }
  }

  Future<void> _emit(String stationId) async {
    final bikes = await getBikesByStation(stationId);

    final controller = _controllers[stationId];

    if (controller != null) {
      controller.add(bikes);
    }
  }
}
