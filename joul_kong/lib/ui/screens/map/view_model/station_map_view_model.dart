import 'package:flutter/material.dart';
import '/data/repositories/bike/bike_repository.dart';
import '/data/repositories/station/station_repository.dart';
import '/ui/screens/map/view_model/station_with_bike_count.dart';
import '/ui/utils/bike_stats.dart';

class StationMapViewModel extends ChangeNotifier {
  final StationRepository stationRepo;
  final BikeRepository bikeRepo;

  StationMapViewModel({required this.stationRepo, required this.bikeRepo}) {
    loadStations();
  }

  List<StationWithBikeCount> stationData = [];
  bool isLoading = false;

  Future<void> loadStations() async {
    try {
      isLoading = true;
      notifyListeners();

      final stations = await stationRepo.getStations();

      final results = await Future.wait(
        stations.map((station) async {
          final bikes = await bikeRepo.getBikesByStation(station.id);

          final available = BikeStats.getAvailableBikeCount(bikes, station.id);

          return StationWithBikeCount(
            station: station,
            availableBikes: available,
          );
        }),
      );

      stationData = results;
    } catch (e) {
      debugPrint("Map error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
