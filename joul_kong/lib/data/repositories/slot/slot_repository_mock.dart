import 'dart:async';
import 'package:joul_kong/data/repositories/slot/slot_repository.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/slot.dart';

class MockSlotRepository implements SlotRepository {
  final List<Slot> _slots = [
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
  ];

  final _controller = StreamController<List<Slot>>.broadcast();

  MockSlotRepository() {
    _emit();
  }

  void _emit() {
    _controller.add(List.from(_slots));
  }

  @override
  Stream<List<Slot>> getSlotsByStation(String stationId) {
    return _controller.stream.map(
      (slots) => slots.where((s) => s.stationId == stationId).toList(),
    );
  }

  @override
  Future<Slot?> getSlotById(String slotId) async {
    try {
      return _slots.firstWhere((slot) => slot.id == slotId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateSlot(Slot updatedSlot) async {
    final index = _slots.indexWhere((slot) => slot.id == updatedSlot.id);

    if (index != -1) {
      _slots[index] = updatedSlot;
      _emit();
    }
  }
}
