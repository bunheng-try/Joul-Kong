import 'package:flutter/material.dart';
import 'package:joul_kong/models/booking.dart';

class BookingState extends ChangeNotifier {
  Booking? _activeBooking;

  Booking? get activeBooking => _activeBooking;

  bool get hasActiveBooking => _activeBooking != null;

  void setBooking(Booking booking) {
    _activeBooking = booking;
    notifyListeners();
  }

  void clearBooking() {
    _activeBooking = null;
    notifyListeners();
  }
}
