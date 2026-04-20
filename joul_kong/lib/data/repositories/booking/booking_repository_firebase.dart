import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:joul_kong/models/booking.dart';
import 'package:joul_kong/models/enums.dart';
import 'booking_repository.dart';

class FirebaseBookingRepository implements BookingRepository {
  final String baseUrl =
      'https://joul-kong-default-rtdb.firebaseio.com';

  Booking? _cachedBooking;

  @override
  Future<Booking?> getActiveBooking(String userId) async {
    final url = Uri.parse('$baseUrl/bookings/$userId.json');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch booking');
    }

    final data = jsonDecode(response.body);

    if (data == null) return null;

    for (final entry in data.entries) {
      final b = entry.value;

      if (b['status'] == 'active') {
        _cachedBooking = Booking(
          id: b['id'],
          userId: b['userId'],
          bikeId: b['bikeId'],
          stationId: b['stationId'],
          status: BookingStatus.active,
          createdAt: DateTime.parse(b['createdAt']),
          expiresAt: DateTime.parse(b['expiresAt']),
        );

        return _cachedBooking;
      }
    }

    return null;
  }

  @override
  Future<Booking> createBooking(Booking booking) async {
    final url = Uri.parse(
      '$baseUrl/bookings/${booking.userId}/${booking.id}.json',
    );

    final response = await http.put(
      url,
      body: jsonEncode({
        'id': booking.id,
        'userId': booking.userId,
        'bikeId': booking.bikeId,
        'stationId': booking.stationId,
        'status': booking.status.name,
        'createdAt': booking.createdAt.toIso8601String(),
        'expiresAt': booking.expiresAt.toIso8601String(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create booking');
    }

    _cachedBooking = booking;
    return booking;
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    final url = Uri.parse('$baseUrl/bookings.json');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch bookings');
    }

    final data = jsonDecode(response.body);

    if (data == null) return;

    for (final userEntry in data.entries) {
      final userId = userEntry.key;
      final bookings = userEntry.value;

      for (final entry in bookings.entries) {
        if (entry.value['id'] == bookingId) {
          final deleteUrl = Uri.parse(
            '$baseUrl/bookings/$userId/${entry.key}.json',
          );

          await http.delete(deleteUrl);
          _cachedBooking = null;
          return;
        }
      }
    }
  }
}
