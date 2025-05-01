import 'package:flutter/material.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/home_screen/widget/race_segment_card.dart';
import 'package:unitime/presentation/views/home_screen/widget/segment_card_widget.dart';
import 'package:unitime/presentation/views/home_screen/widget/unisport_background.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  // my code 
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

  final Race dummyRace = Race(
  id: 1,
  name: "Race Competition at Olympic std",
  description: "hosted by BingBing",
  startTime: DateTime(2025, 5, 25, 8, 0), 
  endTime: DateTime(2025, 5, 25, 12, 0),  
  status: RaceStatus.pending,
  createAt: DateTime.now(),
  updateAt: DateTime.now(),
  segments: [],
  participants: [], // i want 0 for now 
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
        const UnitSportBackground(),  
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),  
        Positioned(
          top: 0,
          left: 0,
          right: 0
          ,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20,vertical:13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello,',style: UniTextStyles.body.copyWith(color: UniColor.white),),
                    Text('Chay Lim',style: UniTextStyles.heading.copyWith(color: UniColor.white),)
                  ],
                ),
                Icon(Icons.refresh, color: UniColor.white, size: 20,),
              ],
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RaceCard(
                  race: dummyRace,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Segments',
                  style: UniTextStyles.label.copyWith(color: UniColor.grayDark),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (Segment segment in sampleSegments) ...[
                  SegmentCard(segment: segment),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
