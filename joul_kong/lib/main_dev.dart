import 'package:joul_kong/data/repositories/bike/bike_repository.dart';
import 'package:joul_kong/data/repositories/bike/bike_repository_mock.dart';
import 'package:joul_kong/data/repositories/slot/slot_repository.dart';
import 'package:joul_kong/data/repositories/slot/slot_repository_mock.dart';
import 'package:joul_kong/data/repositories/station/station_mock_repository.dart';
import 'package:joul_kong/data/repositories/station/station_repository.dart';
import 'package:joul_kong/main_common.dart';
import 'package:joul_kong/ui/states/booking_state.dart';
import 'package:joul_kong/ui/states/pass_state.dart';
import 'package:joul_kong/ui/states/station_state.dart';
import 'package:joul_kong/ui/states/ticket_state.dart';
import 'package:provider/provider.dart';

List<InheritedProvider> get devProviders {
  final stationRepository = MockStationRepository();
  return [
    Provider<StationRepository>(create: (_) => stationRepository),
    Provider<SlotRepository>(create: (_) => MockSlotRepository()),
    Provider<BikeRepository>(create: (_) => MockBikeRepository()),

    ChangeNotifierProvider<BookingState>(create: (_) => BookingState()),
    ChangeNotifierProvider<TicketState>(create: (_) => TicketState()),
    ChangeNotifierProvider<StationState>(create: (_) => StationState(stationRepository)),
    ChangeNotifierProvider<PassState>(create: (_) => PassState()),
  ];
}

void main() {
  mainCommon(devProviders);
}
