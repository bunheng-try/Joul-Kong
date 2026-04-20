import 'package:joul_kong/data/repositories/booking/booking_repository.dart';
import 'package:joul_kong/models/booking.dart';

class MockBookingRepository implements BookingRepository {
  Booking? _activeBooking;

  @override
  Future<Booking?> getActiveBooking(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _activeBooking;
  }

  @override
  Future<Booking> createBooking(Booking booking) async {
    await Future.delayed(const Duration(milliseconds: 300));

    _activeBooking = booking;
    return booking;
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (_activeBooking?.id == bookingId) {
      _activeBooking = null;
    }
  }
}
