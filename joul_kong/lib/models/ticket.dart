import 'package:joul_kong/models/enums.dart';

class Ticket {
  final String id;
  final String userId;

  final TicketStatus status;

  final DateTime createdAt;

  Ticket({
    required this.id,
    required this.userId,
    required this.createdAt, required this.status,
  });
}
