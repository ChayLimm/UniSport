import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';

class SegmentCard extends StatelessWidget {
  final String raceSegmentTitle;
  final int raceSegmentDistance;
  const SegmentCard({super.key,required this.raceSegmentTitle,required this.raceSegmentDistance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: UniColor.black2,
        borderRadius: BorderRadius.circular(UniSpacing.radius)
      ),
      child: ListTile(
        title: Text(
          raceSegmentTitle,
          style:  UniTextStyles.body.copyWith(),
        ),
        subtitle: Text(
          "${raceSegmentDistance.toString()} km",
          style: UniTextStyles.body.copyWith(color: UniColor.grayDark),
        ),
        trailing: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.arrow_forward_ios_outlined),
          color: UniColor.grayDark,
          iconSize: 16,
          ),
      )
    );
  }
}