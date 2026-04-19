import 'package:flutter/material.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/ticket.dart';

class TicketState extends ChangeNotifier {
  Ticket? _activeTicket;

  Ticket? get activeTicket => _activeTicket;

  bool get hasActiveTicket =>
      _activeTicket != null && _activeTicket!.status == TicketStatus.active;

  void setTicket(Ticket ticket) {
    _activeTicket = ticket;
    notifyListeners();
  }

  void markUsed() {
    if (_activeTicket == null) return;

    _activeTicket = Ticket(
      id: _activeTicket!.id,
      userId: _activeTicket!.userId,
      status: TicketStatus.used,
      createdAt: _activeTicket!.createdAt,
    );

    notifyListeners();
  }
}
