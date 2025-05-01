import 'package:flutter/material.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/presentation/themes/theme.dart';

class SegmentCard extends StatelessWidget {
  final Segment segment;
  const SegmentCard({super.key,required this.segment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: UniColor.bgColor,
        borderRadius: BorderRadius.circular(UniSpacing.radius)
      ),
      child: ListTile(
        title: Text(
          segment.name,
          style:  UniTextStyles.body.copyWith(color: UniColor.white),
        ),
        subtitle: Text(
          segment.description,
          style: UniTextStyles.body.copyWith(color: UniColor.grayDark)
        ),
        trailing: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.edit),
          color: UniColor.white,
          iconSize: 16,
          ),
      )
    );
  }
}