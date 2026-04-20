import 'package:joul_kong/models/booking.dart';

abstract class BookingRepository {
  Future<Booking?> getActiveBooking(String userId);

  Future<Booking> createBooking(Booking booking);

  Future<void> cancelBooking(String bookingId);
}
