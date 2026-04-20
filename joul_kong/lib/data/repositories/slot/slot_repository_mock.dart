import 'dart:async';
import 'package:joul_kong/data/data_sources/mock/mock_data.dart';
import 'package:joul_kong/data/repositories/slot/slot_repository.dart';
import 'package:joul_kong/models/slot.dart';

class MockSlotRepository implements SlotRepository {
  List<Slot> get _slots => MockData.slots;

  final _controller = StreamController<List<Slot>>.broadcast();

  MockSlotRepository();

  void _emit() {
    _controller.add(List.unmodifiable(_slots));
  }

  @override
  Stream<List<Slot>> getSlotsByStation(String stationId) {

    Future.microtask(() => _emit());

    return _controller.stream.map((slots) {
      final filtered = slots.where((s) => s.stationId == stationId).toList();


      return filtered;
    });
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
