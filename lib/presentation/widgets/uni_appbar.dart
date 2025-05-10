import 'package:flutter/material.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/utils/time_convertor.dart';
import 'package:unitime/presentation/views/home_screen/home_screen.dart';

class UniAppbar extends StatelessWidget {
  final Race race;
  final VoidCallback tirggerNavigator;
  UniAppbar({super.key,required this.race,required this.tirggerNavigator});

  @override
  Widget build(BuildContext context) {
    
    final startDate = race.startTime!= null ? DateTimeUtils.formatDateTime(race.startTime!) : "Null";

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
          race.name,
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