import 'enums.dart';

class Bike {
  final String id;

  final BikeStatus status;

  final String? currentStationId;
  final String? currentSlotId;
  final String? reservedUserId;

  Bike({
    required this.id,
    required this.status,
    this.currentStationId,
    this.currentSlotId,
    this.reservedUserId,
  });
}
