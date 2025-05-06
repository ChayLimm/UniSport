import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/widgets/label.dart';

class TopParticipant extends StatelessWidget {
  const TopParticipant({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text("ChayLim",style: UniTextStyles.body,),
                  SizedBox(height: 5,),
                  Text("00:05:30",style: UniTextStyles.body,),

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
                  Text("ChayLim",style: UniTextStyles.body,),
                  SizedBox(height: 5,),
                  Text("00:05:30",style: UniTextStyles.body,),
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
                  Text("ChayLim",style: UniTextStyles.body,),
                  SizedBox(height: 5,),
                  Text("00:05:30",style: UniTextStyles.body,),
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