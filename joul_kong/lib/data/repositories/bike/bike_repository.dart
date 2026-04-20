import 'package:joul_kong/models/bike.dart';

abstract class BikeRepository {
  Future<Bike?> getBikeById(String bikeId);
  Future<List<Bike>> getBikesByStation(String stationId);
  Future<void> updateBike(Bike bike);

  Stream<List<Bike>> watchBikesByStation(String stationId);
}
