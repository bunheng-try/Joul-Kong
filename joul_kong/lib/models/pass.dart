import 'enums.dart';

class Pass {
  final String id;
  final String userId;
  final String planId;

  final DateTime startDate;
  final DateTime expiryDate;

  final PassStatus status;

  Pass({
    required this.id,
    required this.userId,
    required this.planId,
    required this.startDate,
    required this.expiryDate,
    required this.status,
  });
}
