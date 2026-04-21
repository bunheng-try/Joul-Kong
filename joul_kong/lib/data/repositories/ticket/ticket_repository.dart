import 'package:joul_kong/models/ticket.dart';

abstract class TicketRepository {
  Future<Ticket?> getActiveTicket(String userId);

  Future<Ticket> createTicket(Ticket ticket);

  Future<void> updateTicket(Ticket ticket);
    
}
