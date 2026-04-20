import 'package:joul_kong/data/repositories/ticket/ticket_repository.dart';
import 'package:joul_kong/models/ticket.dart';

class MockTicketRepository implements TicketRepository {
  Ticket? _activeTicket;

  @override
  Future<Ticket?> getActiveTicket(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _activeTicket;
  }

  @override
  Future<Ticket> createTicket(Ticket ticket) async {
    await Future.delayed(const Duration(milliseconds: 300));

    _activeTicket = ticket;
    return ticket;
  }
}
