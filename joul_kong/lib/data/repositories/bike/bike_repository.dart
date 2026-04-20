import 'package:joul_kong/models/bike.dart';

abstract class BikeRepository {
  Future<Bike?> getBikeById(String bikeId);
  Future<List<Bike>> getBikesByStation(String stationId);
}
