import 'package:flutter/material.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/ui/states/user_state.dart';
import '/data/repositories/bike/bike_repository.dart';
import '/data/repositories/station/station_repository.dart';
import '/ui/screens/map/view_model/station_with_bike_count.dart';

class StationMapViewModel extends ChangeNotifier {
  final StationRepository stationRepo;
  final BikeRepository bikeRepo;
  final UserState userState;

  StationMapViewModel({required this.stationRepo, required this.bikeRepo, required this.userState}) {
    loadStations();
  }

  List<StationWithBikeCount> stationData = [];
  List<StationWithBikeCount> nearbyStations = [];
  bool isLoading = false;

  Future<void> loadStations() async {
    try {
      isLoading = true;
      notifyListeners();

      double userLat = userState.currentUser.latitude;
      double userLng = userState.currentUser.longitude;

      final stations = await stationRepo.getStations();

      final List<StationWithBikeCount> results = await Future.wait(
        stations.map((station) async {
          final bikes = await bikeRepo.getBikesByStation(station.id);

          final available = bikes
              .where((b) => b.status == BikeStatus.available)
              .length;

          return StationWithBikeCount(
            station: station,
            availableBikes: available,
          );
        }),
      );

      stationData = results;

      final nearby = await stationRepo.getNearbyStations(
        latitude: userLat,
        longitude: userLng,
      );

      final Map<String, StationWithBikeCount> lookup = {
        for (final item in results) item.station.id: item,
      };

      nearbyStations = nearby
          .map((station) => lookup[station.id])
          .whereType<StationWithBikeCount>()
          .toList();
    } catch (e) {
      debugPrint("Map error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
