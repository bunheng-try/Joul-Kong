import 'package:joul_kong/data/data_sources/mock/mock_data.dart';
import 'package:joul_kong/models/bike.dart';
import 'package:joul_kong/models/enums.dart';
import 'bike_repository.dart';

class MockBikeRepository implements BikeRepository {
  List<Bike> get _bikes =>  MockData.bikes;

  @override
  Future<Bike?> getBikeById(String bikeId) async {
    try {
      return _bikes.firstWhere((b) => b.id == bikeId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Bike>> getBikesByStation(String stationId) async {
    final result = _bikes
        .where((b) => b.currentStationId == stationId)
        .toList();

    return result;
  }

  Future<void> updateBike(Bike updatedBike) async {
    final index = _bikes.indexWhere((b) => b.id == updatedBike.id);

    if (index != -1) {
      _bikes[index] = updatedBike;
    }
  }

  Future<void> reserveBike(String bikeId, String userId) async {
    final index = _bikes.indexWhere((b) => b.id == bikeId);

    if (index != -1) {
      final bike = _bikes[index];

      _bikes[index] = Bike(
        id: bike.id,
        status: BikeStatus.reserved,
        currentStationId: bike.currentStationId,
        currentSlotId: bike.currentSlotId,
        reservedUserId: userId,
      );
    }
  }
}
