import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/presentation/provider/checkpoint_provider.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/widget/finished_bib_number.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/widget/race_segment_card.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/widget/search_bar.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/widget/unfinished_bib_number.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';
import 'package:unitime/presentation/widgets/timer.dart';

class TrackingRaceSegmentScreen extends StatelessWidget {
  TrackingRaceSegmentScreen({super.key});

  final Race race = Race(
    id: 1234,
    name: "Race run lg - olympic",
    description: "This is the description",
    status: RaceStatus.pending,
    createAt: DateTime.now(),
    updateAt: DateTime.now(),
    startTime: DateTime.now().subtract(const Duration(hours: 1)),
  );

  final List<Segment> sampleSegments = [
    Segment(
      id: 1,
      raceId: 101,
      description: 'Segment 1 Description',
      name: 'Segment 1',
      orderNumber: 1,
      checkpoint: null,
    ),
    Segment(
      id: 2,
      raceId: 101,
      description: 'Segment 2 Description',
      name: 'Segment 2',
      orderNumber: 2,
      checkpoint: null,
    ),
    Segment(
      id: 3,
      raceId: 101,
      description: 'Segment 3 Description',
      name: 'Segment 3',
      orderNumber: 3,
      checkpoint: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context, listen: false);
    final currentSegment = sampleSegments.first;

    raceProvider.start(race); // Start race timer

    TextEditingController myController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SegmentCard(
              raceSegmentTitle: currentSegment.name,
              raceSegmentDistance: 500,
            ),
            const SizedBox(height: 10),
            const StopWatch(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Participants",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: SizedBox(width: 100)),
                CustomSearchbar(
                  controller: myController,
                  onChanged: (value) {
                    print("Search: $value");
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 5,
                  runSpacing: 10,
                  children: List.generate(10, (index) {
                    final bibNumber = "Bib 00${index + 1}";
                    final participantId = index + 1;
                    return Consumer2<CheckpointProvider, RaceProvider>(
                      builder:
                          (context, checkpointProvider, raceProvider, child) {
                        final isFinished = checkpointProvider.isCompleted(
                          currentSegment.id,
                          participantId,
                        );

                        return InkWell(
                          onTap: () {
                            print("${{currentSegment.name}} $bibNumber tapped");
                            print("Checkpoint ID: ${currentSegment.id}");
                            if (!isFinished) {
                              // Pass BuildContext to recordCheckpoint method
                              checkpointProvider.recordCheckpoint(
                                participantId: participantId,
                                segmentId: currentSegment.id,
                              );
                            }
                          },
                          child: isFinished
                              ? FinishedBibNumber(
                                  bibNumber: bibNumber,
                                  finishedTime: checkpointProvider.getParticipantCheckpointTime(
                                    currentSegment.id,
                                    participantId,
                                  ),
                                )
                              : UnFinishedBibNumber(bibNumber: bibNumber),
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
            UniButton(
              onTrigger: () {
                // Additional logic for 2-step record button
              },
              color: UniColor.primary,
              label: "2 Step Record",
            ),
          ],
        ),
      ),
    );
  }
}
