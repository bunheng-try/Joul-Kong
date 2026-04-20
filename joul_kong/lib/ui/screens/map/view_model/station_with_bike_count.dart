import '/models/station.dart';

class StationWithBikeCount {
  final Station station;
  final int availableBikes;

  StationWithBikeCount({required this.station, required this.availableBikes});
}
