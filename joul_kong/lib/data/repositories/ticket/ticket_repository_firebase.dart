import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:joul_kong/data/dtos/ticket_dto.dart';
import 'package:joul_kong/data/repositories/ticket/ticket_repository.dart';
import 'package:joul_kong/models/ticket.dart';

class FirebaseTicketRepository implements TicketRepository {
  final String baseUrl;

  FirebaseTicketRepository(this.baseUrl);

  @override
  Future<Ticket?> getActiveTicket(String userId) async {
    final url = Uri.parse('$baseUrl/tickets.json');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch tickets");
    }

    final data = jsonDecode(response.body);

    if (data == null) return null;

    final Map<String, dynamic> map = data;

    for (final entry in map.entries) {
      final dto = TicketDto.fromJson(entry.key, entry.value);

      if (dto.userId == userId && dto.status == 'active') {
        return dto.toDomain();
      }
    }

    return null;
  }

  @override
  Future<Ticket> createTicket(Ticket ticket) async {
    final url = Uri.parse('$baseUrl/tickets.json');

    final dto = TicketDto.fromDomain(ticket);

    final response = await http.post(url, body: jsonEncode(dto.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to create ticket");
    }

    final data = jsonDecode(response.body);

    return Ticket(
      id: data['name'],
      userId: ticket.userId,
      status: ticket.status,
      createdAt: ticket.createdAt,
    );
  }


  @override
  Future<void> updateTicket(Ticket ticket) async {
    final url = Uri.parse('$baseUrl/tickets/${ticket.id}.json');

    final dto = TicketDto.fromDomain(ticket);

    final response = await http.put(url, body: jsonEncode(dto.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to update ticket");
    }
  }
}
