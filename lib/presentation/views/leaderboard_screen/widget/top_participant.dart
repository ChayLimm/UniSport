import 'package:flutter/material.dart';
import 'package:unitime/domain/services/race_service.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/widgets/label.dart';
import 'package:unitime/utils/formatter.dart';

class TopParticipant extends StatelessWidget {
  final ParticipantDuration top1 ;
  final ParticipantDuration top2 ;
  final ParticipantDuration top3 ;
  const TopParticipant({super.key,required this.top1, required this.top2, required this.top3});

  @override
  Widget build(BuildContext context) {

    final top1Duration = formatDuration(top1.duration);
    final top2Duration = formatDuration(top2.duration);
    final top3Duration = formatDuration(top3.duration);

    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(children: [
      //background
        background(),
      //top participant
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //second
              Column(
                children: [
                  SizedBox(height: 88,),
                  Label(label: "2nd"),
                  SizedBox(height: 5,),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: UniColor.grayMedium
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(top2.username,style: UniTextStyles.body,),
                  SizedBox(height: 5,),
                  Text(top2Duration,style: UniTextStyles.body,),

                ],
              ),
               Column(
                children: [
                  Label(label: "1nd"),
                  SizedBox(height: 5,),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: UniColor.grayMedium
                    ),
                  ),
                   SizedBox(height: 5,),
                  Text(top1.username,style: UniTextStyles.body,),
                  SizedBox(height: 5,),
                  Text(top1Duration,style: UniTextStyles.body,),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 88,),
                  Label(label: "3nd"),
                  SizedBox(height: 5,),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: UniColor.grayMedium
                    ),
                  ),
                   SizedBox(height: 5,),
                  Text(top3.username,style: UniTextStyles.body,),
                  SizedBox(height: 5,),
                  Text(top3Duration,style: UniTextStyles.body,),
                ],
              )

            ],
          ),
        )
      ],
      ),
    );
  }

  Widget background(){
    return          Column(
           children: [
             Expanded(
               flex: 1,
               child: Container(
         
               )),
               Expanded(
               flex: 2,
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   color: UniColor.black1
                 ),
               ))
         
           ],
         );

  }

}