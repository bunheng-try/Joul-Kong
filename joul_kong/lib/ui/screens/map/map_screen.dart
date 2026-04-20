import 'package:flutter/material.dart';
import '/data/repositories/bike/bike_repository.dart';
import '/data/repositories/station/station_repository.dart';
import '/ui/screens/map/widgets/map_content.dart';
import '/ui/screens/map/view_model/station_map_view_model.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StationMapViewModel(
        stationRepo: context.read<StationRepository>(),
        bikeRepo: context.read<BikeRepository>(),
      ),
      child: const MapCotent(),
    );
  }
}
