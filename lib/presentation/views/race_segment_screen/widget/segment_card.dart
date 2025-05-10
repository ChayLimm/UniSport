import 'package:flutter/material.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/tracking_segment_screen.dart';

class SegmentCard extends StatelessWidget {
  final Segment segment;
  const SegmentCard({super.key,required this.segment});

  void _onPressed(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return TrackingRaceSegmentScreen(segment: segment);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: UniColor.black2,
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        onTap: (){
            _onPressed(context);
        
        },
        title: Text(
          segment.name,
          style:  UniTextStyles.body.copyWith(fontWeight: FontWeight.bold),
        ),
        // subtitle: Text(
        //   segment.description?? "Null",
        //   style: UniTextStyles.body.copyWith(color: UniColor.grayDark)
        // ),
        trailing: Icon(
         
          Icons.arrow_forward_ios_outlined,
          color: UniColor.grayDark,
          size: 16,
          ),
      )
    );
  }
}