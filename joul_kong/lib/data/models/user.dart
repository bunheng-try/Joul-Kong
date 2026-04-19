class User {
  final String id;
  final String name;

  final String? activePassId;
  final String? activeTicketId;

  User({
    required this.id,
    required this.name,
    this.activePassId,
    this.activeTicketId,
  });
}