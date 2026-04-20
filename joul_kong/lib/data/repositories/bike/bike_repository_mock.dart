import 'dart:async';
import 'package:joul_kong/data/data_sources/mock/mock_data.dart';
import 'package:joul_kong/models/bike.dart';
import 'bike_repository.dart';

class MockBikeRepository implements BikeRepository {
  List<Bike> get _bikes => MockData.bikes;

  final Map<String, StreamController<List<Bike>>> _controllers = {};

  void _emit(String stationId) {
    final controller = _controllers[stationId];
    if (controller != null) {
      controller.add(
        _bikes.where((b) => b.currentStationId == stationId).toList(),
      );
    }
  }

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
    return _bikes.where((b) => b.currentStationId == stationId).toList();
  }

  @override
  Future<Bike?> getBikeById(String bikeId) async {
    try {
      return _bikes.firstWhere((b) => b.id == bikeId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateBike(Bike updatedBike) async {
    final index = _bikes.indexWhere((b) => b.id == updatedBike.id);

    if (index != -1) {
      _bikes[index] = updatedBike;

      if (updatedBike.currentStationId != null) {
        _emit(updatedBike.currentStationId!);
      }
    }
  }
}
