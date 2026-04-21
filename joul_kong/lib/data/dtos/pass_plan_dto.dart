import 'package:joul_kong/models/pass_plan.dart';

class PassPlanDto {
  final String id;
  final String name;
  final double price;
  final int durationHours;
  final int? freeMinutesPerRide;

  PassPlanDto({
    required this.id,
    required this.name,
    required this.price,
    required this.durationHours,
    this.freeMinutesPerRide,
  });

  factory PassPlanDto.fromJson(String id, Map<String, dynamic> json) {
    return PassPlanDto(
      id: id,
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      durationHours: json['durationHours'],
      freeMinutesPerRide: json['freeMinutesPerRide'],
    );
  }

  PassPlan toDomain() {
    return PassPlan(
      id: id,
      name: name,
      price: price,
      durationHours: durationHours,
      freeMinutesPerRide: freeMinutesPerRide,
    );
  }
}
