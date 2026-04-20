import 'package:flutter/material.dart';
import 'package:joul_kong/data/repositories/bike/bike_repository.dart';
import 'package:joul_kong/data/repositories/slot/slot_repository.dart';
import 'package:joul_kong/data/repositories/station/station_repository.dart';
import 'package:joul_kong/ui/screens/station_detail/view_model/station_detail_view_model.dart';
import 'package:joul_kong/ui/screens/station_detail/widgets/station_detail_content.dart';
import 'package:provider/provider.dart';

class StationDetailScreen extends StatelessWidget {
  final String stationId;

  const StationDetailScreen({super.key, required this.stationId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StationDetailViewModel(
        stationId: stationId,
        bikeRepository: context.read<BikeRepository>(),
        slotRepository: context.read<SlotRepository>(),
        stationRepository: context.read<StationRepository>(),
      ),
      child: StationDetailContent(stationId: stationId),
    );
  }
}
