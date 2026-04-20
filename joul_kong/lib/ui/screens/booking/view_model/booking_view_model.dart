import 'package:flutter/material.dart';
import 'package:joul_kong/data/repositories/bike/bike_repository.dart';
import 'package:joul_kong/data/repositories/booking/booking_repository.dart';
import 'package:joul_kong/data/repositories/station/station_repository.dart';
import 'package:joul_kong/data/repositories/ticket/ticket_repository.dart';
import 'package:joul_kong/models/bike.dart';
import 'package:joul_kong/models/booking.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/station.dart';
import 'package:joul_kong/models/ticket.dart';
import 'package:joul_kong/ui/states/booking_state.dart';
import 'package:joul_kong/ui/states/pass_state.dart';
import 'package:joul_kong/ui/states/ticket_state.dart';
import 'package:joul_kong/ui/states/user_state.dart';

enum BookingResult { success, noAccess, alreadyBooked, notFound }

class BookingViewModel extends ChangeNotifier {
  final BookingRepository bookingRepository;
  final BikeRepository bikeRepository;
  final TicketRepository ticketRepository;
  final StationRepository stationRepository;

  final Station station;

  final BookingState bookingState;
  final TicketState ticketState;
  final PassState passState;
  final UserState userState;
  final String bikeId;

  BookingViewModel({
    required this.bookingRepository,
    required this.ticketRepository,
    required this.bikeRepository,
    required this.stationRepository,
    required this.bookingState,
    required this.ticketState,
    required this.passState,
    required this.userState,
    required this.station,
    required this.bikeId,

  });

  late String stationId = station.id;

  bool isLoading = false;

  Future<BookingResult> bookBike() async {
    if (bookingState.hasActiveBooking) {
      return BookingResult.alreadyBooked;
    }

    final bike = await bikeRepository.getBikeById(bikeId);

    if (bike == null) {
      return BookingResult.notFound;
    }

    final hasAccess = passState.hasValidPass || ticketState.hasActiveTicket;

    if (!hasAccess) {
      return BookingResult.noAccess;
    }

    await _createBooking(bike);

    return BookingResult.success;
  }

  Future<void> _createBooking(Bike bike) async {
    isLoading = true;
    notifyListeners();

    final userId = userState.currentUser.id;

    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      bikeId: bike.id,
      stationId: stationId,
      status: BookingStatus.active,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(minutes: 15)),
    );

    final created = await bookingRepository.createBooking(booking);
    bookingState.setBooking(created);

    await bikeRepository.updateBike(
      Bike(
        id: bike.id,
        status: BikeStatus.reserved,
        currentStationId: bike.currentStationId,
        currentSlotId: bike.currentSlotId,
        reservedUserId: userId,
      ),
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> buyTicket() async {
    final userId = userState.currentUser.id;

    final ticket = Ticket(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      status: TicketStatus.active,
      createdAt: DateTime.now(),
    );

    final createdTicket = await ticketRepository.createTicket(ticket);
    ticketState.setTicket(createdTicket);
  }

}
