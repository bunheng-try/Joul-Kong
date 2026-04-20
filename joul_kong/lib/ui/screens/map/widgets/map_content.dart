import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/ui/screens/map/view_model/station_map_view_model.dart';
import '/ui/screens/station_detail/station_detail_screen.dart';
import 'package:provider/provider.dart';

class MapCotent extends StatefulWidget {
  const MapCotent({super.key});

  @override
  State<MapCotent> createState() => _MapCotentState();
}

class _MapCotentState extends State<MapCotent> {
  GoogleMapController? controller;

  final LatLng center = const LatLng(11.5564, 104.9282);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StationMapViewModel>();

    final markers = vm.stationData.map((data) {
      final station = data.station;
      final available = data.availableBikes;

      final hasBikes = available > 0;

      return Marker(
        markerId: MarkerId(station.id),
        position: LatLng(station.latitude, station.longitude),

        infoWindow: InfoWindow(
          title: station.name,
          snippet: "$available bikes available",
        ),

        icon: BitmapDescriptor.defaultMarkerWithHue(
          hasBikes ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StationDetailScreen(stationId: station.id),
            ),
          );
        },
      );
    }).toSet();

    return Scaffold(
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(target: center, zoom: 13),
              onMapCreated: (c) => controller = c,
              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
