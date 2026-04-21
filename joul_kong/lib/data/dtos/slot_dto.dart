import 'package:joul_kong/models/slot.dart';
import 'package:joul_kong/models/enums.dart';

class SlotDto {
  final String id;
  final String stationId;
  final String? bikeId;
  final String status;

  SlotDto({
    required this.id,
    required this.stationId,
    this.bikeId,
    required this.status,
  });

  factory SlotDto.fromJson(String id, Map<String, dynamic> json) {
    return SlotDto(
      id: id,
      stationId: json['stationId'] ?? '',
      bikeId: json['bikeId'],
      status: json['status'] ?? 'empty',
    );
  }

  Map<String, dynamic> toJson() {
    return {'stationId': stationId, 'bikeId': bikeId, 'status': status};
  }

  Slot toDomain() {
    return Slot(
      id: id,
      stationId: stationId,
      bikeId: bikeId,
      status: SlotStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => SlotStatus.empty,
      ),
    );
  }

  factory SlotDto.fromDomain(Slot slot) {
    return SlotDto(
      id: slot.id,
      stationId: slot.stationId,
      bikeId: slot.bikeId,
      status: slot.status.name,
    );
  }
}
