import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';

class FinishedBibNumber extends StatelessWidget {
  final String bibNumber;
  final DateTime finishedTime;
  const FinishedBibNumber({super.key,required this.bibNumber, required this.finishedTime});
  @override
  Widget build(BuildContext context) {

    //render data
    final raceProvider = Provider.of<RaceProvider>(context, listen: false);
    Duration duration = finishedTime.difference(raceProvider.seletectedRace!.startTime!);

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: UniColor.backgroundColor.withOpacity(0.5), // dark background
        borderRadius: BorderRadius.circular(UniSpacing.radius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(bibNumber,
            style: UniTextStyles.heading.copyWith(color: UniColor.grayDark),
          ),
          const SizedBox(height: 5),
          Text(formatDuration(duration),
            style: UniTextStyles.body.copyWith(color: UniColor.grayDark),
          ),
        ],
      ),
    );
  }
}


String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final hours   = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  final centis  = twoDigits((duration.inMilliseconds.remainder(1000) ~/ 10));

  return "$hours:$minutes:$seconds.$centis";
}
