import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/station_detail/view_model/station_detail_view_model.dart';
import 'package:joul_kong/ui/screens/station_detail/widgets/stat_card.dart';

class StationStats extends StatelessWidget {
  final StationDetailViewModel vm;
  const StationStats({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatCard(
          icon: Icons.pedal_bike,
          value: "${vm.getAvailableBikeCount()}",
          label: "Available",
          color: const Color(0xFF7BF1A8),
        ),

        StatCard(
          icon: Icons.local_parking,
          value: "${vm.emptySlotCount}",
          label: "Parks",
          color: const Color(0xFF6EC6FF),
        ),

        StatCard(
          icon: Icons.map,
          value: "${vm.getDistanceToUser().toStringAsFixed(2)} km",
          label: "Distance",
          color: const Color(0xFFB0BEC5),
        ),
      ],
    );
  }
}
