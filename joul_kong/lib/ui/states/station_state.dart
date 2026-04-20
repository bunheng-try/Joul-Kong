import 'package:flutter/material.dart';
import '../../data/repositories/station/station_repository.dart';
import '/models/station.dart';
import '/ui/utils/aync_value.dart';

class StationState extends ChangeNotifier {
  final StationRepository _stationRepository;

  StationState(this._stationRepository);

  AsyncValue<List<Station>> stations = AsyncValue.loading();
  AsyncValue<List<Station>> nearbyStations = AsyncValue.loading();

  Future<void> loadStations() async {
    stations = AsyncValue.loading();
    notifyListeners();

    try {
      final data = await _stationRepository.getStations();
      stations = AsyncValue.success(data);
    } catch (e) {
      stations = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> loadNearbyStations({
    required double latitude,
    required double longitude,
  }) async {
    nearbyStations = AsyncValue.loading();
    notifyListeners();

    try {
      final data = await _stationRepository.getNearbyStations(
        latitude: latitude,
        longitude: longitude,
      );
      nearbyStations = AsyncValue.success(data);
    } catch (e) {
      nearbyStations = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> search(String query) async {
    stations = AsyncValue.loading();
    notifyListeners();

    try {
      final data = await _stationRepository.searchStations(query);
      stations = AsyncValue.success(data);
    } catch (e) {
      stations = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
