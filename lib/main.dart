import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/data/repositories/checkpoint_implement.dart';
import 'package:unitime/data/repositories/participant_implement.dart';
import 'package:unitime/data/repositories/race_implementation.dart';
import 'package:unitime/domain/services/participant_service.dart';
import 'package:unitime/domain/services/checkpoint_service.dart';
import 'package:unitime/domain/services/race_service.dart';
import 'package:unitime/presentation/provider/checkpoint_provider.dart';
import 'package:unitime/presentation/provider/participant_provider.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/home_screen/home_screen.dart';

void main() {

  ///
  /// Injection
  ///
  RaceService.initialize(RaceImplementation());
  ParticipantService.initialize(ParticipantImplement());

  CheckpointService.initialize(CheckpointImplement());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RaceProvider()),
        ChangeNotifierProvider(create: (_) => CheckpointProvider()),
        ChangeNotifierProvider(create: (_) => ParticipantProvider()),
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
      home: HomeScreen(), // Widget where you'll access the provider
    );
  }
}
  