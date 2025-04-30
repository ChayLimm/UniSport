import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/race_segment_screen/widget/segment_appbar.dart';
import 'package:unitime/presentation/views/race_segment_screen/widget/segment_card.dart';
import 'package:unitime/presentation/views/race_segment_screen/widget/timer.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';
import 'package:unitime/presentation/widgets/label.dart';
import 'package:unitime/presentation/widgets/uni_bottomnav.dart';

class RaceSegmentScreen extends StatelessWidget {
  RaceSegmentScreen({super.key});

  //dummy data
  final Race race = Race(
      id: 1234,
      name: "Race run lg - olympic",
      description: "This is the description",
      status: RaceStatus.pending,
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      startTime:  DateTime.now().subtract(Duration(hours: 1))
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
    final raceProvider = context.read<RaceProvider>();
    raceProvider.start(race);

    return Scaffold(
      bottomNavigationBar: UniBottomnav(),
      backgroundColor: UniColor.backGroundColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Custome appbar
            SegmentAppBar(
              race: race,
            ),
            const SizedBox(
              height: 10,
            ),
            participantFinish(race),
            const SizedBox(
              height: 10,
            ),
            StopWatch(),
            const SizedBox(
              height: 10,
            ),
            Label(label: 'Segments'),
            const SizedBox(
              height: 10,
            ),
            for (Segment segment in sampleSegments) ...[
              SegmentCard(segment: segment),
              const SizedBox(
                height: 10,
              ),
            ],
            Spacer(),
            UniButton(
                onTrigger: () {
                  raceProvider.endRace(race.id);
                },
                color: UniColor.red,
                label: "End Race")
          ],
        ),
      ),
    );
  }

  Widget participantFinish(Race race) {
    ///
    ///Compute data here
    ///
    int finishedParticapnt = 0;
    int totalParticpant = 10;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: UniColor.black2,
        borderRadius: BorderRadius.circular(9),
      ),
      child: ListTile(
        leading: Text(
          "${finishedParticapnt.toString()} / ${totalParticpant.toString()}",
          style: UniTextStyles.body.copyWith(color: UniColor.white),
        ),
        title: Text(
          'Particiapants has finished',
          style: UniTextStyles.body.copyWith(color: UniColor.grayDark),
        ),
      ),
    );
  }
}
