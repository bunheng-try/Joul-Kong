import 'package:joul_kong/models/slot.dart';

abstract class SlotRepository {
  Stream<List<Slot>> getSlotsByStation(String stationId);

  Future<Slot?> getSlotById(String slotId);

  Future<void> updateSlot(Slot slot);
}
