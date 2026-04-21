import 'package:joul_kong/models/ticket.dart';
import 'package:joul_kong/models/enums.dart';

class TicketDto {
  final String id;
  final String userId;
  final String status;
  final String createdAt;

  TicketDto({
    required this.id,
    required this.userId,
    required this.status,
    required this.createdAt,
  });

  factory TicketDto.fromJson(String id, Map<String, dynamic> json) {
    return TicketDto(
      id: id,
      userId: json['userId'] ?? '',
      status: json['status'] ?? 'active',
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'status': status, 'createdAt': createdAt};
  }

  Ticket toDomain() {
    return Ticket(
      id: id,
      userId: userId,
      status: TicketStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => TicketStatus.active,
      ),
      createdAt: DateTime.parse(createdAt),
    );
  }

  factory TicketDto.fromDomain(Ticket ticket) {
    return TicketDto(
      id: ticket.id,
      userId: ticket.userId,
      status: ticket.status.name,
      createdAt: ticket.createdAt.toIso8601String(),
    );
  }
}
