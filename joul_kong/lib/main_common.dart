import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/map/map_screen.dart';
import 'package:joul_kong/ui/states/booking_state.dart';
import 'package:joul_kong/ui/states/pass_state.dart';
import 'package:joul_kong/ui/states/ticket_state.dart';
import 'package:joul_kong/ui/states/user_state.dart';
import 'package:provider/provider.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Inter'),
        home: MyApp(),
      ),
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userState = context.read<UserState>();
      final passState = context.read<PassState>();
      final ticketState = context.read<TicketState>();
      final bookingState = context.read<BookingState>();

      final userId = userState.currentUser.id;

      await passState.load(userId);
      await ticketState.load(userId);
      await bookingState.load(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MapScreen();
  }
}
