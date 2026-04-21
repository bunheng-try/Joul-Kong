import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joul_kong/ui/screens/map/widgets/map_header.dart';
import 'package:joul_kong/ui/screens/pass_selection/pass_selection_screen.dart';
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
  Set<Marker> _markers = {};
  final Map<String, BitmapDescriptor> _badgeCache = {};

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

  Widget build(BuildContext context) {
    final vm = context.watch<StationMapViewModel>();

    if (_markers.isEmpty && vm.stationData.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _buildMarkers(vm);
      });
    }

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
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),

                MapHeader(
                  onPassTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PassSelectionScreen(
                          userId: vm.userState.currentUser.id
                        ),
                      ),
                    );
                  },
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

  void _buildMarkers(StationMapViewModel vm) async {
    final List<Marker> markerList = [];

    for (final data in vm.stationData) {
      final station = data.station;
      final available = data.availableBikes;

      final hasBikes = available > 0;

      final key = "${station.id}_$available";

      if (!_badgeCache.containsKey(key)) {
        _badgeCache[key] = await _createNumberMarker(
          count: available,
          color: hasBikes ? Colors.blue : Colors.red,
        );
      }

      markerList.add(
        Marker(
          markerId: MarkerId(station.id),
          position: LatLng(station.latitude, station.longitude),

          icon: _badgeCache[key]!,

          infoWindow: InfoWindow(
            title: station.name,
            snippet: "$available bikes available",
          ),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StationDetailScreen(stationId: station.id),
              ),
            );
          },
        ),
      );
    }

    setState(() {
      _markers = markerList.toSet();
    });
  }

  Future<BitmapDescriptor> _createNumberMarker({
    required int count,
    required Color color,
  }) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    const width = 56.0;
    const height = 30.0;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final bgPaint = Paint()..color = color;

    final rrect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0, 0, width, height),
      const Radius.circular(14),
    );

    canvas.drawRRect(rrect, bgPaint);

    canvas.drawRRect(rrect, borderPaint);

    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(Icons.directions_bike.codePoint),
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'MaterialIcons',
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    iconPainter.layout();

    iconPainter.paint(canvas, Offset(8, (height - iconPainter.height) / 2));

    final linePaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 1;

    canvas.drawLine(Offset(24, 6), Offset(32, height - 6), linePaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: count.toString(),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    textPainter.paint(canvas, Offset(36, (height - textPainter.height) / 2));

    final img = await recorder.endRecording().toImage(
      width.toInt(),
      height.toInt(),
    );

    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
