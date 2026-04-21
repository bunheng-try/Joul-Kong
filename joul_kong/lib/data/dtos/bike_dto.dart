import 'package:joul_kong/models/bike.dart';
import 'package:joul_kong/models/enums.dart';

class BikeDto {
  final String id;
  final String status;
  final String? currentStationId;
  final String? currentSlotId;
  final String? reservedUserId;

  BikeDto({
    required this.id,
    required this.status,
    this.currentStationId,
    this.currentSlotId,
    this.reservedUserId,
  });

  factory BikeDto.fromJson(String id, Map<String, dynamic> json) {
    return BikeDto(
      id: id,
      status: json['status'] ?? 'available',
      currentStationId: json['currentStationId'],
      currentSlotId: json['currentSlotId'],
      reservedUserId: json['reservedUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'currentStationId': currentStationId,
      'currentSlotId': currentSlotId,
      'reservedUserId': reservedUserId,
    };
  }

  Bike toDomain() {
    return Bike(
      id: id,
      status: BikeStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => BikeStatus.available,
      ),
      currentStationId: currentStationId,
      currentSlotId: currentSlotId,
      reservedUserId: reservedUserId,
    );
  }

  factory BikeDto.fromDomain(Bike bike) {
    return BikeDto(
      id: bike.id,
      status: bike.status.name,
      currentStationId: bike.currentStationId,
      currentSlotId: bike.currentSlotId,
      reservedUserId: bike.reservedUserId,
    );
  }
}
