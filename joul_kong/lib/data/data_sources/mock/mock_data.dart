import 'package:joul_kong/models/bike.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/pass_plan.dart';
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
    Station(
      id: "station9",
      name: "Chroy Changvar Bridge Station",
      latitude: 11.6005,
      longitude: 104.9413,
    ),

    Station(
      id: "station10",
      name: "Chbar Ampov Market Station",
      latitude: 11.5256,
      longitude: 104.9420,
    ),

    Station(
      id: "station11",
      name: "Sen Sok City Station",
      latitude: 11.6102,
      longitude: 104.8901,
    ),

    Station(
      id: "station12",
      name: "NR6 Highway Exit Station",
      latitude: 11.6508,
      longitude: 104.8805,
    ),

    Station(
      id: "station13",
      name: "Koh Pich South Gate Station",
      latitude: 11.5442,
      longitude: 104.9378,
    ),

    Station(
      id: "station14",
      name: "Russey Keo Riverside Station",
      latitude: 11.6209,
      longitude: 104.9204,
    ),

    Station(
      id: "station15",
      name: "Airport Road Station",
      latitude: 11.5401,
      longitude: 104.8473,
    ),
  ];

  // =====================
  // BIKES
  // =====================
 static final List<Bike> bikes = [
    // Station 1
    Bike(
      id: "b1",
      status: BikeStatus.available,
      currentStationId: "station1",
      currentSlotId: "s1",
    ),
    Bike(
      id: "b2",
      status: BikeStatus.available,
      currentStationId: "station1",
      currentSlotId: "s2",
    ),
    Bike(
      id: "b3",
      status: BikeStatus.available,
      currentStationId: "station1",
      currentSlotId: "s3",
    ),
    Bike(
      id: "b4",
      status: BikeStatus.reserved,
      currentStationId: "station1",
      currentSlotId: "s4",
      reservedUserId: "u1",
    ),

    // Station 2
    Bike(
      id: "b5",
      status: BikeStatus.available,
      currentStationId: "station2",
      currentSlotId: "s5",
    ),
    Bike(
      id: "b6",
      status: BikeStatus.available,
      currentStationId: "station2",
      currentSlotId: "s6",
    ),
    Bike(
      id: "b7",
      status: BikeStatus.reserved,
      currentStationId: "station2",
      currentSlotId: "s7",
    ),

    // Station 3
    Bike(
      id: "b8",
      status: BikeStatus.available,
      currentStationId: "station3",
      currentSlotId: "s11",
    ),
    Bike(
      id: "b9",
      status: BikeStatus.available,
      currentStationId: "station3",
      currentSlotId: "s12",
    ),
  ];
  // =====================
  // SLOTS
  // =====================
  static final List<Slot> slots = [
    // ================= station 1 =================
    Slot(
      id: "s1",
      stationId: "station1",
      bikeId: "b1",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s2",
      stationId: "station1",
      bikeId: "b2",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s3",
      stationId: "station1",
      bikeId: "b3",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s4",
      stationId: "station1",
      bikeId: "b4",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s5",
      stationId: "station1",
      bikeId: null,
      status: SlotStatus.empty,
    ),
    Slot(
      id: "s6",
      stationId: "station1",
      bikeId: null,
      status: SlotStatus.empty,
    ),

    // ================= station 2 =================
    Slot(
      id: "s7",
      stationId: "station2",
      bikeId: "b5",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s8",
      stationId: "station2",
      bikeId: "b6",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s9",
      stationId: "station2",
      bikeId: "b7",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s10",
      stationId: "station2",
      bikeId: null,
      status: SlotStatus.empty,
    ),
    Slot(
      id: "s11",
      stationId: "station2",
      bikeId: null,
      status: SlotStatus.empty,
    ),
    Slot(
      id: "s12",
      stationId: "station2",
      bikeId: null,
      status: SlotStatus.empty,
    ),

    // ================= station 3 =================
    Slot(
      id: "s13",
      stationId: "station3",
      bikeId: "b8",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s14",
      stationId: "station3",
      bikeId: "b9",
      status: SlotStatus.occupied,
    ),
    Slot(
      id: "s15",
      stationId: "station3",
      bikeId: null,
      status: SlotStatus.empty,
    ),
    Slot(
      id: "s16",
      stationId: "station3",
      bikeId: null,
      status: SlotStatus.empty,
    ),
    Slot(
      id: "s17",
      stationId: "station3",
      bikeId: null,
      status: SlotStatus.empty,
    ),
    Slot(
      id: "s18",
      stationId: "station3",
      bikeId: null,
      status: SlotStatus.empty,
    ),
  ];


  static final List<PassPlan> passPlans = [
    PassPlan(
      id: "day",
      name: "Day Pass",
      price: 1.0,
      durationHours: 24,
      freeMinutesPerRide: 30,
    ),
    PassPlan(
      id: "monthly",
      name: "Monthly Pass",
      price: 10.0,
      durationHours: 24 * 30,
    ),
    PassPlan(
      id: "annual",
      name: "Annual Pass",
      price: 100.0,
      durationHours: 24 * 365,
    ),
  ];
}
