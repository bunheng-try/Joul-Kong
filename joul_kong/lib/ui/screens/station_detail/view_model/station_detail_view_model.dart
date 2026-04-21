import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joul_kong/data/repositories/bike/bike_repository.dart';
import 'package:joul_kong/data/repositories/slot/slot_repository.dart';
import 'package:joul_kong/data/repositories/station/station_repository.dart';
import 'package:joul_kong/models/bike.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/slot.dart';
import 'package:joul_kong/models/station.dart';
import 'package:joul_kong/ui/states/user_state.dart';
import 'package:joul_kong/ui/utils/bike_stats.dart';
import 'package:joul_kong/ui/utils/calculate_distance.dart';

enum SlotDisplayState { empty, available, reserved, maintenance, unknown }

class StationDetailViewModel extends ChangeNotifier {
  final SlotRepository slotRepository;
  final BikeRepository bikeRepository;
  final StationRepository stationRepository;
  final UserState userState;


  late Station station;
  final String stationId;

  bool isLoading = true;

  bool _bikesLoaded = false;

  List<Slot> slots = [];
  List<Bike> bikes = [];

  StreamSubscription? _slotSub;
  StreamSubscription? _bikeSub;

  StationDetailViewModel({
    required this.slotRepository,
    required this.bikeRepository,
    required this.stationId,
    required this.stationRepository,
    required this.userState,

  }) {
    _init();
  }

  Future<void> _init() async {
    try {
      isLoading = true;
      notifyListeners();

      station = await stationRepository.getStationById(stationId);

      bikes = await bikeRepository.getBikesByStation(stationId);

      _bikesLoaded = true;

      _listenSlots();
      _listenBikes();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  double getDistanceToUser() {
    return calculateDistance(
      userState.currentUser.latitude,
      userState.currentUser.longitude,
      station.latitude,
      station.longitude,
    );
  }

  void _listenSlots() {
    _slotSub = slotRepository.getSlotsByStation(stationId).listen((data) {
      slots = data;

      notifyListeners();
    });
  }

  void _listenBikes() {
    _bikeSub = bikeRepository.watchBikesByStation(stationId).listen((data) {
      bikes = data;
      _bikesLoaded = true;
      notifyListeners();
    });
  }

  Bike? _getBike(String bikeId) {
    try {
      return bikes.firstWhere((b) => b.id == bikeId);
    } catch (_) {
      return null;
    }
  }

  int getAvailableBikeCount() {
    return BikeStats.getAvailableBikeCount(bikes, stationId);
  }

  int get emptySlotCount {
    return slots.where((s) => s.bikeId == null).length;
  }

  SlotDisplayState getSlotDisplay(Slot slot) {
    if (!_bikesLoaded) {
      return SlotDisplayState.unknown;
    }

    if (slot.bikeId == null) {
      return SlotDisplayState.empty;
    }

    final bike = _getBike(slot.bikeId!);

    if (bike == null) {
      return SlotDisplayState.unknown;
    }

    switch (bike.status) {
      case BikeStatus.available:
        return SlotDisplayState.available;

      case BikeStatus.reserved:
        return SlotDisplayState.reserved;

      case BikeStatus.inUse:
        return SlotDisplayState.maintenance;

      case BikeStatus.maintenance:
        return SlotDisplayState.maintenance;
    }
  }

  @override
  void dispose() {
    _slotSub?.cancel();
    _bikeSub?.cancel();
    super.dispose();
  }
}
