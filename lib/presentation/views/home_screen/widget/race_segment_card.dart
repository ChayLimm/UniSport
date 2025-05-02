
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/presentation/themes/theme.dart';

class RaceCard extends StatelessWidget {
  final Race race;
  const RaceCard({
    super.key,
    required this.race,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: UniColor.bgColor, 
        borderRadius: BorderRadius.circular(UniSpacing.radius),
      ),
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
                  'Participants: ${race.participants?.length ?? 0}',
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
                  DateFormat('MMM dd, yyyy').format(race.startTime!),
                  style: UniTextStyles.label.copyWith(color: UniColor.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
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
