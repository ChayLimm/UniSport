import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/tracking_race_screen/widget/finished_bib_number.dart';
import 'package:unitime/presentation/views/tracking_race_screen/widget/race_segment_card.dart';
import 'package:unitime/presentation/views/tracking_race_screen/widget/search_bar.dart';
import 'package:unitime/presentation/views/tracking_race_screen/widget/unfinished_bib_number.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';
import 'package:unitime/presentation/widgets/timer.dart';

class TrackingRaceSegmentScreen extends StatelessWidget {
  TrackingRaceSegmentScreen({super.key});

  //dummy data
  final Race race = Race(
      id: 1234,
      name: "Race run lg - olympic",
      description: "This is the description",
      status: RaceStatus.pending,
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      startTime: DateTime.now().subtract(Duration(hours: 1)));
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
    bool isFinished=false;
    final raceProvider = context.read<RaceProvider>();
    raceProvider.start(race);
    TextEditingController myController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SegmentCard(
              raceSegmentTitle: "Segment 1",
              raceSegmentDistance: 500,
            ),
            const SizedBox(
              height: 10,
            ),
            StopWatch(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Segments",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  width: 100,
                )),
                CustomSearchbar(
                  controller: myController,
                  onChanged: (value) {
                    print("Search: $value");
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 250, // Adjust height based on how many rows you expect
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 5,
                  runSpacing: 10,
                  children: List.generate(10, (index) {
                    return InkWell(
                      onTap: (){
                        isFinished=true;
                      },
                      child: isFinished?FinishedBibNumber():UnFinishedBibNumber()
                      ); // Your fixed-size widget
                  }),
                ),
              ),
            ),
            Spacer(),
            UniButton(
                onTrigger: () {
                  raceProvider.endRace(race.id);
                },
                color: UniColor.primary,
                label: "2 Step record"),
          ],
        ),
      ),
    );
  }
}
