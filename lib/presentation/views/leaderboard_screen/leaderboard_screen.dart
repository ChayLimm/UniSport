import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/services/race_service.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/home_screen/home_screen.dart';
import 'package:unitime/presentation/views/leaderboard_screen/widget/participant_leaderboard_tile.dart';
import 'package:unitime/presentation/views/leaderboard_screen/widget/top_participant.dart';
import 'package:unitime/presentation/widgets/uni_app_bar.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<ParticipantDuration> result = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final raceProvider = context.read<RaceProvider>();
      final data = await RaceService.instance.getLeaderBoardForRace(context,raceProvider.seletectedRace!.id);
      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error loading leaderboard: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniColor.backGroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        
        child: SingleChildScrollView(
          child: Column(
            children: [
              UniAppBar(title: "Leaderboard", onTapBack: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }
              ),
               TopParticipant(
                top1: result[0],
                top2: result[1],
                top3: result[2],
              ),
              const SizedBox(height: 5),
              if(result.isNotEmpty)...{
                 for(int i = 3; i < result.length; i++)...[
                ParticipantLeaderboardTile(
                  color: result[i].color!, 
                  order: i+1, 
                  bibNumber: result[i].bibNumber, 
                  userName: result[i].username, 
                  duration: result[i].duration
                  )
              ]
              }else...{
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: UniColor.black2,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child:  Center(child: Text("Race has not end",style: UniTextStyles.body,)),
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}



