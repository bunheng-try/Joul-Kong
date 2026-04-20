import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/ui/screens/map/widgets/station_tile.dart';
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

  BitmapDescriptor? blueMarker;
  BitmapDescriptor? redMarker;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    blueMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(96, 96)),
      'assets/icons/blue_marker.png',
    );

    redMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(96, 96)),
      'assets/icons/red_marker.png',
    );

    setState(() {});
  }

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

        icon: hasBikes
            ? (blueMarker ?? BitmapDescriptor.defaultMarker)
            : (redMarker ?? BitmapDescriptor.defaultMarker),

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
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: center,
                    zoom: 13,
                  ),
                  onMapCreated: (c) => controller = c,
                  markers: markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),

                DraggableScrollableSheet(
                  initialChildSize: 0.2,
                  minChildSize: 0.1,
                  maxChildSize: 0.6,
                  expand: true,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10),
                        ],
                      ),
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        children: [
                          const SizedBox(height: 10),

                          // HANDLE
                          Center(
                            child: Container(
                              width: 40,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Center(
                            child: Text(
                              "Nearby Stations",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                          const SizedBox(height: 10),

                          ...vm.nearbyStations.map((data) {
                            return StationTile(
                              name: data.station.name,
                              availableBikes: data.availableBikes,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => StationDetailScreen(
                                      stationId: data.station.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
