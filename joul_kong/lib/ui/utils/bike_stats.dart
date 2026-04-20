import 'package:joul_kong/models/bike.dart';
import 'package:joul_kong/models/enums.dart';

class BikeStats {
  static int getAvailableBikeCount(List<Bike> bikes, String stationId) {
    return bikes
        .where(
          (b) =>
              b.currentStationId == stationId &&
              b.status == BikeStatus.available,
        )
        .length;
  }
}
