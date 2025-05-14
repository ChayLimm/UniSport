import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/utils/formatter.dart';

class FinishedBibNumber extends StatelessWidget {
  final Participant selectedParticipant;
  final Checkpoint checkpoint;

  final void Function(
    Participant selectedParticipant,
    Duration duration,
    Checkpoint checkpoint,
  ) onPressed;

  const FinishedBibNumber({
    super.key,
    required this.selectedParticipant,
    required this.checkpoint,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context, listen: false);
    final Duration duration = checkpoint.createAt.difference(raceProvider.seletectedRace!.startTime!);

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: UniColor.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(UniSpacing.radius),
      ),
      child: Stack(
        children: [
          // Top-right edit button
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: Icon(Icons.edit, color: UniColor.grayDark),
              onPressed: () {
                onPressed(selectedParticipant, duration, checkpoint);
              },
            ),
          ),

          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedParticipant.bibNumber,
                  style: UniTextStyles.heading.copyWith(color: UniColor.grayDark),
                ),
                const SizedBox(height: 5),
                Text(
                  formatDuration(duration),
                  style: UniTextStyles.body.copyWith(color: UniColor.grayDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
