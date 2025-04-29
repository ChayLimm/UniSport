import 'package:flutter/material.dart';
import 'package:unitime/presentation/provider/stopwatch_provider.dart';
import 'package:provider/provider.dart';
import 'package:unitime/presentation/themes/theme.dart';

class StopWatch extends StatelessWidget {
  const StopWatch({super.key});

  @override
  Widget build(BuildContext context) {

    final timerProvider = context.watch<StopWatchProvider>();

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20
      ),
      child: Center(
        child: Text(
          timerProvider.formattedTime,
          style: UniTextStyles.heading.copyWith(color: UniColor.white,fontSize: 32),
        ),
      ),
    );
  }
}