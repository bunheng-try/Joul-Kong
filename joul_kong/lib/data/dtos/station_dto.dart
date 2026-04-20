import 'package:joul_kong/models/station.dart';

class StationDto {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  StationDto({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory StationDto.fromJson(String id, Map<String, dynamic> json) {
    return StationDto(
      id: id,
      name: json['name'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'latitude': latitude, 'longitude': longitude};
  }

  Station toDomain() {
    return Station(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory StationDto.fromDomain(Station station) {
    return StationDto(
      id: station.id,
      name: station.name,
      latitude: station.latitude,
      longitude: station.longitude,
    );
  }
}
