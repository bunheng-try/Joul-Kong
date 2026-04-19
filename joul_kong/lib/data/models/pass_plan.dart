class PassPlan {
  final String id;
  final String name;

  final double price;
  final int durationHours;

  final int? freeMinutesPerRide;

  PassPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.durationHours,
    this.freeMinutesPerRide,
  });
}
