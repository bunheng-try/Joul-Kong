import 'enums.dart';

class Booking {
  final String id;
  final String userId;
  final String bikeId;
  final String stationId;

  final BookingStatus status;

  final DateTime createdAt;
  final DateTime expiresAt;

  Booking({
    required this.id,
    required this.userId,
    required this.bikeId,
    required this.stationId,
    required this.status,
    required this.createdAt,
    required this.expiresAt,
  });
}
