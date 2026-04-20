import 'package:joul_kong/models/booking.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDto {
  static const userIdKey = 'userId';
  static const bikeIdKey = 'bikeId';
  static const stationIdKey = 'stationId';
  static const statusKey = 'status';
  static const createdAtKey = 'createdAt';
  static const expiresAtKey = 'expiresAt';

  static Booking fromFirestore(String id, Map<String, dynamic> json) {
    return Booking(
      id: id,
      userId: json[userIdKey],
      bikeId: json[bikeIdKey],
      stationId: json[stationIdKey],
      status: BookingStatus.values.byName(json[statusKey]),
      createdAt: (json[createdAtKey] as Timestamp).toDate(),
      expiresAt: (json[expiresAtKey] as Timestamp).toDate(),
    );
  }

  static Map<String, dynamic> toFirestore(Booking booking) {
    return {
      userIdKey: booking.userId,
      bikeIdKey: booking.bikeId,
      stationIdKey: booking.stationId,
      statusKey: booking.status.name,
      createdAtKey: booking.createdAt,
      expiresAtKey: booking.expiresAt,
    };
  }
}
