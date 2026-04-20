import 'package:flutter/material.dart';
import 'package:joul_kong/data/repositories/bike/bike_repository.dart';
import 'package:joul_kong/data/repositories/booking/booking_repository.dart';
import 'package:joul_kong/data/repositories/station/station_repository.dart';
import 'package:joul_kong/data/repositories/ticket/ticket_repository.dart';
import 'package:joul_kong/models/station.dart';
import 'package:joul_kong/ui/screens/booking/view_model/booking_view_model.dart';
import 'package:joul_kong/ui/screens/booking/widgets/booking_content.dart';
import 'package:joul_kong/ui/states/booking_state.dart';
import 'package:joul_kong/ui/states/pass_state.dart';
import 'package:joul_kong/ui/states/ticket_state.dart';
import 'package:joul_kong/ui/states/user_state.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  final Station station;
  final String bikeId;

  const BookingScreen({
    super.key,
    required this.station,
    required this.bikeId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingViewModel(
        bookingRepository: context.read<BookingRepository>(),
        ticketRepository: context.read<TicketRepository>(),
        stationRepository: context.read<StationRepository>(),
        bikeRepository: context.read<BikeRepository>(),
        bookingState: context.read<BookingState>(),
        ticketState: context.read<TicketState>(),
        passState: context.read<PassState>(),
        userState: context.read<UserState>(),
        station: station,
        bikeId: bikeId,
      ),
      child: BookingContent(),
    );
  }
}
