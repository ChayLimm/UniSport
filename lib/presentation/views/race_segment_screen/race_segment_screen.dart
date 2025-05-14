import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/domain/services/race_service.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/home_screen/home_screen.dart';
import 'package:unitime/presentation/views/leaderboard_screen/leaderboard_screen.dart';
import 'package:unitime/presentation/views/race_segment_screen/widget/segment_card.dart';
import 'package:unitime/presentation/widgets/timer.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';
import 'package:unitime/presentation/widgets/confirmation_dialog.dart';
import 'package:unitime/presentation/widgets/label.dart';
import 'package:unitime/presentation/widgets/uni_appbar.dart';

class RaceSegmentScreen extends StatelessWidget {
  const RaceSegmentScreen({super.key});

  Future<void> _onEndRace(BuildContext context)async{




    final raceProvider = context.read<RaceProvider>();
    
    //refresh race
    final allRaces = await raceProvider.getAllRace();
    raceProvider.setRace(allRaces[0]);

    final segments = await RaceService.instance.getSegmentByRace(raceProvider.seletectedRace!.id);

    bool isConfirm  = await showConfirmationDialog(context: context, title: "Are you sure?", content: "You want to end this race?");
    if(isConfirm){
      //   for(Segment segment in segments){
      //     if(!segment.markAsFinish){
      //       UniSportSnackbar.show(context: context, message: "${segment.name} have not end yet", backgroundColor: UniColor.red);
      //       return;
      //     }
      
      // }
      raceProvider.endRace(raceProvider.seletectedRace!.id);
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return LeaderboardScreen();
      }));
    }
  }

  
  @override
  Widget build(BuildContext context) {
    ///
    ///Render data
    ///
   
    final raceProvider = context.watch<RaceProvider>();
    final race = raceProvider.seletectedRace ?? Race(id: 12, name: "name", description: "description", status: RaceStatus.pending, createAt: DateTime.now(), updateAt: DateTime.now());
    final segments = raceProvider.currentSegment;
    raceProvider.start(race.startTime!); 
    
    

    return Scaffold(
      backgroundColor: UniColor.backGroundColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Custome appbar
            UniAppbar(
              race: race,
              tirggerNavigator: (){
                Navigator.push(context, MaterialPageRoute(builder: (Context){
                  return HomeScreen();
                }));
              },
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
            for (Segment segment in segments) ...[
              SegmentCard(segment: segment),
              const SizedBox(
                height: 10,
              ),
            ],
            Spacer(),
            UniButton(
                onTrigger: () async {
                 await _onEndRace(context);
                },
                color: UniColor.red,
                label: "End Race"
                )
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
