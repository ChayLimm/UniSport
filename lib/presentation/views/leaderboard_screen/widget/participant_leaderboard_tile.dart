import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';

class ParticipantLeaderboardTile extends StatelessWidget {
  final int order;
  final String bibNumber;
  final String userName;
  final Duration duration;
  final Color color;
  const ParticipantLeaderboardTile({super.key,required this.color, required this.order, required this.bibNumber, required this.userName, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: UniColor.black2,
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        leading: Text("${order.toString()}.",style: UniTextStyles.body,),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(bibNumber,style: UniTextStyles.body,),
            SizedBox(width: 10,),
            Text(userName.toString(),style: UniTextStyles.body.copyWith(color: UniColor.grayDark,)),
          ],
        ),
        trailing: Text(formatDuration(duration),style: UniTextStyles.body.copyWith(color: color,),
      ),
      ));
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    final hundredths = ((duration.inMilliseconds % 1000) / 10).floor().toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds.$hundredths';
  }

}