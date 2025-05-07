
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/participant_screen/participants_screen.dart';
import 'package:unitime/presentation/views/race_segment_screen/race_segment_screen.dart';

class RaceCard extends StatelessWidget {
  final Race race;
  const RaceCard({
    super.key,
    required this.race,
  });

  void pushScreen(BuildContext context){
     if(race.startTime ==null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ParticipantsScreen(
        )));}else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RaceSegmentScreen( )));
        }
  }

  @override
  Widget build(BuildContext context) {
    final participants = context.watch<RaceProvider>().currentParticipant;
    return GestureDetector(
      onTap:(){ 
        pushScreen(context);
        },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: UniColor.backgroundColor, 
          borderRadius: BorderRadius.circular(UniSpacing.radius),
        ),
        child: GestureDetector(
          onTap: () {
                    pushScreen(context);
            
          },
          child: Stack(
            children: [
              // Main content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      race.name,
                      style: UniTextStyles.body.copyWith(color: UniColor.white),
                    ),
                    Text(
                      'Hosted by ${race.description}',
                      style: UniTextStyles.body.copyWith(color: UniColor.grayDark)
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Participants: ${participants.length}',
                      style: UniTextStyles.body.copyWith(color: UniColor.white),
                    ),
                  ],
                ),
              ),
                
              // Date tag in bottom right
              Positioned(
                bottom: 0,
                right: 0,
                child: ClipPath(
                  clipper: _TagClipper(),
                  child: Container(
                    color: UniColor.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: Text(
                      race.startTime != null ? DateFormat('MMM dd, yyyy').format(race.startTime!) : "Not start yet",
                      style: UniTextStyles.label.copyWith(color: UniColor.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(20, 0); // Start slightly right
    path.lineTo(size.width, 0); // Top right
    path.lineTo(size.width, size.height); // Bottom right
    path.lineTo(0, size.height); // Bottom left
    path.lineTo(20, 0); // Back to start (creates the diagonal cut)
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
