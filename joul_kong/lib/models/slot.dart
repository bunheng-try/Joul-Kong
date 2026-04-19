import 'package:joul_kong/models/enums.dart';

class Slot {
  final String id;
  final String stationId;
  final String? bikeId;
  final SlotStatus status;

  Slot({required this.id, required this.stationId, this.bikeId, required this.status});
}
