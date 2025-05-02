import 'package:flutter/material.dart';


void main() {

  ///
  /// Injection
  ///
  RaceService.initialize(RaceImplementation());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RaceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      theme: appTheme,
      home: RaceSegmentScreen(), // Widget where you'll access the provider
    );
  }
}
