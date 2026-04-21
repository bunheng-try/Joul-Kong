import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/pass.dart';

class PassDto {
  final String id;
  final String userId;
  final String planId;
  final String startDate;
  final String expiryDate;
  final String status;

  PassDto({
    required this.id,
    required this.userId,
    required this.planId,
    required this.startDate,
    required this.expiryDate,
    required this.status,
  });

  factory PassDto.fromJson(String id, Map<String, dynamic> json) {
    return PassDto(
      id: id,
      userId: json['userId'],
      planId: json['planId'],
      startDate: json['startDate'],
      expiryDate: json['expiryDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'planId': planId,
      'startDate': startDate,
      'expiryDate': expiryDate,
      'status': status,
    };
  }

  Pass toDomain() {
    return Pass(
      id: id,
      userId: userId,
      planId: planId,
      startDate: DateTime.parse(startDate),
      expiryDate: DateTime.parse(expiryDate),
      status: PassStatus.values.firstWhere((e) => e.name == status),
    );
  }
}
