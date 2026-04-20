import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/map/map_screen.dart';
import 'package:joul_kong/ui/screens/station_detail/station_detail_screen.dart';
import 'package:provider/provider.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
        home: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // return StationDetailScreen(stationId: "station1");
    return MapScreen();
  }
}
