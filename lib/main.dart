import 'package:flutter/material.dart';
import 'package:unitime/presentation/provider/stopwatch_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/race_segment_screen/race_segment_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StopWatchProvider()),
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
