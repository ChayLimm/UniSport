import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/data/repositories/race_implementation.dart';
import 'package:unitime/domain/services/checkpoint_service.dart';
import 'package:unitime/domain/services/race_service.dart';
import 'package:unitime/presentation/provider/checkpoint_provider.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';

import 'presentation/views/tracking_race_segment_screen/tracking_segment_screen.dart';

void main() {

  ///
  /// Injection
  ///
  RaceService.initialize(RaceImplementation());
  CheckpointService.initialize(RaceImplementation());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RaceProvider()),
        ChangeNotifierProvider(create: (_) => CheckpointProvider()),
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
      debugShowCheckedModeBanner: false,
      home: TrackingRaceSegmentScreen(), // Widget where you'll access the provider
    );
  }
}
  