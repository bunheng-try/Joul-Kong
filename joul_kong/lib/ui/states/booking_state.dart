import 'package:flutter/material.dart';
import 'package:joul_kong/data/repositories/booking/booking_repository.dart';
import 'package:joul_kong/models/booking.dart';

class BookingState extends ChangeNotifier {
  final BookingRepository _repo;

  BookingState(this._repo);

  Booking? _activeBooking;

  Booking? get activeBooking => _activeBooking;

  bool get hasActiveBooking => _activeBooking != null;

  Future<void> load(String userId) async {
    final booking = await _repo.getActiveBooking(userId);
    _activeBooking = booking;
    notifyListeners();
  }

  void setBooking(Booking booking) {
    _activeBooking = booking;
    notifyListeners();
  }

  void clearBooking() {
    _activeBooking = null;
    notifyListeners();
  }
}
