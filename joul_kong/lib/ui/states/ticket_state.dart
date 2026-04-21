import 'package:flutter/material.dart';
import 'package:joul_kong/data/repositories/ticket/ticket_repository.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/ticket.dart';

class TicketState extends ChangeNotifier {
  final TicketRepository _repo;

  TicketState(this._repo);

  Ticket? _activeTicket;
  bool _isLoading = false;
  String? _error;

  Ticket? get activeTicket => _activeTicket;
  bool get isLoading => _isLoading;
  String? get error => _error;

  bool get hasActiveTicket =>
      _activeTicket != null && _activeTicket!.status == TicketStatus.active;

  Future<void> load(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _activeTicket = await _repo.getActiveTicket(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTicket(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final ticket = Ticket(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        status: TicketStatus.active,
        createdAt: DateTime.now(),
      );

      final created = await _repo.createTicket(ticket);
      _activeTicket = created;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markUsed() async {
    if (_activeTicket == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      final updated = Ticket(
        id: _activeTicket!.id,
        userId: _activeTicket!.userId,
        status: TicketStatus.used,
        createdAt: _activeTicket!.createdAt,
      );

      await _repo.updateTicket(updated);

      _activeTicket = updated;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearTicket() {
    _activeTicket = null;
    notifyListeners();
  }
}
