import 'enums.dart';

class Payment {
  final String id;
  final String userId;

  final double amount;

  final PaymentType type;
  final PaymentMethod method;
  final PaymentStatus status;

  final String relatedId;

  final DateTime createdAt;

  Payment({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.method,
    required this.status,
    required this.relatedId,
    required this.createdAt,
  });
}
