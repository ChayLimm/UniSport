import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/data/repositories/race_implementation.dart';
import 'package:unitime/domain/services/race_service.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/home_screen/home_screen.dart';
import 'package:unitime/presentation/views/race_segment_screen/race_segment_screen.dart';


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
      home: HomeScreen(), // Widget where you'll access the provider
    );
  }
}
  