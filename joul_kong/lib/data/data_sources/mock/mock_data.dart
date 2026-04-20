import 'package:joul_kong/models/bike.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/slot.dart';
import 'package:joul_kong/models/station.dart';

class MockData {
  // =====================
  // STATIONS
  // =====================
  static final List<Station> stations = [
    Station(
      id: "station1",
      name: "Phnom Penh Central Market",
      latitude: 11.5761,
      longitude: 104.9230,
    ),
    Station(
      id: "station2",
      name: "Wat Phnom Station",
      latitude: 11.5758,
      longitude: 104.9251,
    ),
    Station(
      id: "station3",
      name: "Riverside Park",
      latitude: 11.5676,
      longitude: 104.9300,
    ),
    Station(
      id: "station4",
      name: "Royal Palace Area",
      latitude: 11.5621,
      longitude: 104.9314,
    ),
    Station(
      id: "station5",
      name: "Independence Monument",
      latitude: 11.5564,
      longitude: 104.9282,
    ),
    Station(
      id: "station6",
      name: "BKK1 District Station",
      latitude: 11.5529,
      longitude: 104.9287,
    ),
    Station(
      id: "station7",
      name: "Aeon Mall Phnom Penh",
      latitude: 11.5489,
      longitude: 104.9346,
    ),
    Station(
      id: "station8",
      name: "Russian Market",
      latitude: 11.5346,
      longitude: 104.9164,
    ),
  ];

  // =====================
  // BIKES
  // =====================
  static final List<Bike> bikes = [
    Bike(
      id: "b1",
      status: BikeStatus.available,
      currentStationId: "station1",
      currentSlotId: "s1",
    ),
    Bike(
      id: "b2",
      status: BikeStatus.reserved,
      currentStationId: "station1",
      currentSlotId: "s3",
      reservedUserId: "u1",
    ),
    Bike(
      id: "b3",
      status: BikeStatus.available,
      currentStationId: "station2",
      currentSlotId: "s5",
    ),
    Bike(
      id: "b4",
      status: BikeStatus.maintenance,
      currentStationId: "station1",
      currentSlotId: null,
    ),
  ];

  // =====================
  // SLOTS
  // =====================
  static final List<Slot> slots = [
    Slot(
      id: "s1",
      stationId: "station1",
      bikeId: "b1",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s2",
      stationId: "station1",
      bikeId: null,
      status: SlotStatus.empty,
    ),
    Slot(
      id: "s3",
      stationId: "station1",
      bikeId: "b2",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s4",
      stationId: "station1",
      bikeId: null,
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s5",
      stationId: "station2",
      bikeId: "b3",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s6",
      stationId: "station2",
      bikeId: null,
      status: SlotStatus.occupied,
    ),
  ];
}
