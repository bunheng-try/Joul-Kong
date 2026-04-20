import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
}
