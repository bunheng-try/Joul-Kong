import 'package:joul_kong/data/data_sources/firebase/bike_repository_firebase.dart';
import 'package:joul_kong/data/repositories/booking/booking_repository_firebase.dart';
import 'package:joul_kong/data/repositories/pass/pass_repository_firebase.dart';
import 'package:joul_kong/data/repositories/slot/slot_repository_firebase.dart';
import 'package:joul_kong/data/repositories/ticket/ticket_repository_firebase.dart';

import '/data/data_sources/firebase/station_repository_firebase.dart';
import '/constants/app_config.dart';
import '/data/repositories/bike/bike_repository.dart';
import '/data/repositories/booking/booking_repository.dart';
import '/data/repositories/pass/pass_repository.dart';
import '/data/repositories/pass/pass_repository_mock.dart';
import '/data/repositories/slot/slot_repository.dart';
import '/data/repositories/station/station_repository.dart';
import '/data/repositories/ticket/ticket_repository.dart';
import '/data/repositories/ticket/ticket_repository_mock.dart';
import '/main_common.dart';
import '/ui/states/booking_state.dart';
import '/ui/states/pass_state.dart';
import '/ui/states/station_state.dart';
import '/ui/states/ticket_state.dart';
import '/ui/states/user_state.dart';
import 'package:provider/provider.dart';

List<InheritedProvider> get prodProviders {
  final stationRepository = FirebaseStationRepository(AppConfig.firebaseUrl);
  final passRepository = FirebasePassRepository(AppConfig.firebaseUrl);
  final ticketRepository = FirebaseTicketRepository(AppConfig.firebaseUrl);


  return [
    Provider<StationRepository>(create: (_) => stationRepository),
    Provider<SlotRepository>(create: (_) => FirebaseSlotRepository(AppConfig.firebaseUrl)),
    Provider<BikeRepository>(
      create: (_) => FirebaseBikeRepository(AppConfig.firebaseUrl),
    ),
    Provider<BookingRepository>(create: (_) => FirebaseBookingRepository(AppConfig.firebaseUrl)),
    Provider<PassRepository>(create: (_) => passRepository),
    Provider<TicketRepository>(create: (_) => ticketRepository),

    ChangeNotifierProvider<BookingState>(create: (_) => BookingState()),
    ChangeNotifierProvider<TicketState>(create: (_) => TicketState(ticketRepository)),
    ChangeNotifierProvider<StationState>(
      create: (_) => StationState(stationRepository),
    ),
    ChangeNotifierProvider<PassState>(create: (_) => PassState(passRepository)),
    ChangeNotifierProvider<UserState>(create: (_) => UserState()),
  ];
}

void main() {
  mainCommon(prodProviders);
}
