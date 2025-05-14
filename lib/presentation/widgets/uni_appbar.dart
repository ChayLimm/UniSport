import 'package:flutter/material.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/utils/time_convertor.dart';

class UniAppbar extends StatelessWidget {
  final Race race;
  final Segment? segment;
  final VoidCallback tirggerNavigator;
  UniAppbar({super.key,required this.race,required this.tirggerNavigator,this.segment});

  @override
  Widget build(BuildContext context) {
    
    final startDate = race.startTime!= null ? DateTimeUtils.formatDateTime(race.startTime!) : "Null";
    final title = segment != null ? "${race.name} - ${segment!.name}" : race.name;

    return Container( 
      decoration: BoxDecoration(
        color: UniColor.black1,
        borderRadius: BorderRadius.circular(9),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: IconButton(
          onPressed: (){
          tirggerNavigator();
        }, 
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: UniColor.grayDark,
          size: 16,
        )
        ),
        title: Text(
          title,
          style: UniTextStyles.body.copyWith(color: UniColor.white,fontWeight: FontWeight.bold)
          ),
          subtitle:  Text(
          startDate,
          style: UniTextStyles.body.copyWith(color: UniColor.grayDark)
          ),
      ),
    );
  }
}