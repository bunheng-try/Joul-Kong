import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:joul_kong/data/dtos/slot_dto.dart';

import 'package:joul_kong/data/repositories/slot/slot_repository.dart';
import 'package:joul_kong/models/slot.dart';

class FirebaseSlotRepository implements SlotRepository {
  final String baseUrl;

  FirebaseSlotRepository(this.baseUrl);

  final Map<String, StreamController<List<Slot>>> _controllers = {};

  @override
  Stream<List<Slot>> getSlotsByStation(String stationId) {
    if (!_controllers.containsKey(stationId)) {
      _controllers[stationId] = StreamController<List<Slot>>.broadcast();

      _emit(stationId);
    }

    return _controllers[stationId]!.stream;
  }

  @override
  Future<Slot?> getSlotById(String slotId) async {
    final url = Uri.parse('$baseUrl/slots/$slotId.json');

    final response = await http.get(url);

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);

    if (data == null) return null;

    return SlotDto.fromJson(slotId, data).toDomain();
  }

  @override
  Future<void> updateSlot(Slot updatedSlot) async {
    final url = Uri.parse('$baseUrl/slots/${updatedSlot.id}.json');

    final dto = SlotDto.fromDomain(updatedSlot);

    final response = await http.patch(url, body: jsonEncode(dto.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to update slot");
    }

    _emit(updatedSlot.stationId);
  }

  Future<void> _emit(String stationId) async {
    final url = Uri.parse('$baseUrl/slots.json');

    final response = await http.get(url);

    if (response.statusCode != 200) return;

    final data = jsonDecode(response.body);

    if (data == null) return;

    final Map<String, dynamic> map = data;

    final slots = map.entries.map((entry) {
      return SlotDto.fromJson(entry.key, entry.value).toDomain();
    }).toList();

    final filtered = slots.where((s) => s.stationId == stationId).toList();

    final controller = _controllers[stationId];

    if (controller != null) {
      controller.add(filtered);
    }
  }
}
