import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/presentation/provider/participant_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/utils/time_convertor.dart';
import 'package:unitime/presentation/views/participant_screen/participant_form_dialog.dart';
import 'package:unitime/presentation/views/participant_screen/widgets/participant_header.dart';
import 'package:unitime/presentation/views/participant_screen/widgets/participant_list.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';
import 'package:unitime/presentation/widgets/uni_app_bar.dart';

class ParticipantsScreen extends StatefulWidget {
  const ParticipantsScreen({super.key});

  @override
  State<ParticipantsScreen> createState() => _ParticipantsScreenState();
}

class _ParticipantsScreenState extends State<ParticipantsScreen> {
  // dummy data
  final Race race = Race(
      id: 01,
      name: 'Summer Race Competition',
      description: 'Nothing',
      status: RaceStatus.pending,
      createAt: DateTime.now(),
      updateAt: DateTime.now());

  final List<Participant> participants = [
    Participant(
        id: 01,
        raceId: 01,
        userName: 'User',
        bibNumber: 'BIB 001',
        registerTime: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now()),
    Participant(
        id: 02,
        raceId: 01,
        userName: 'User',
        bibNumber: 'BIB 002',
        registerTime: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now()),
    Participant(
        id: 03,
        raceId: 01,
        userName: 'User',
        bibNumber: 'BIB 002',
        registerTime: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now()),
    Participant(
        id: 04,
        raceId: 01,
        userName: 'User',
        bibNumber: 'BIB 003',
        registerTime: DateTime.now(),
        createAt: DateTime.now(),
        updateAt: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    final participants =
        context.watch<ParticipantProvider>().participants; // get participants
    return Scaffold(
      backgroundColor: UniColor.backGroundColor,
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            // app bar for race section
            UniAppBar(
                title: race.name,
                subTitle: DateTimeUtils.formatDateTime(race.createAt),
                onTapBack: () {
                  // navigate back
                  Navigator.pop(context);
                }),

            const SizedBox(height: 12),

            // add participant section
          ParticipantHeader(
            participants: participants,
            race: race,
            onAdd: (participant) async {
              await showParticipantModalForm(
                context: context,
                race: race,
                onSaved: (participant) async{
                  await context.read<ParticipantProvider>().addParticipant(participant);
                },
              );
            },
          ),

            const SizedBox(height: 16),

            // Participant List Views - edit/delete action
            ParticipantList(
              participants: participants,
              race: race,
              onSaved: (participant) async{
                // call provider to update participant -> service -> repo -> api
                await context.read<ParticipantProvider>().updateParticipant(participant);
              },
              onDeleted: (participant) {
                // implement
                context.read<ParticipantProvider>().deleteParticipant(participant.id!);
              },
            ),

            // start race - action button (UniButton)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: UniButton(
                  onTrigger: () {},
                  color: UniColor.primary,
                  label: "Start Race"),
            )
          ])),
    );
  }
}






// widget participant header with add
// Widget _buildParticipantsHeader(
//   BuildContext context, 
//   List<Participant> participants, 
//   Race race) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         'Participants',
//         style: UniTextStyles.label.copyWith(
//           color: UniColor.grayLight,
//           fontWeight: FontWeight.w300,
//         ),
//       ),
//       // button for add participants
//       InkWell(
//         borderRadius: BorderRadius.circular(8),
//         onTap: () async{
//           // handle add participant - call full dialog 
//           await showParticipantModalForm(
//           context: context,
//           race: race, 
//           onSaved: (Participant participant) {
//             print('New participant added: ${participant.userName}');
            
//             // update participants list - add new participant (use setsate jsut test)
            
//           },
//         );
//         },
//         child: Container(
//           width: 40,
//           height: 32,
//           decoration: BoxDecoration(
//             color: UniColor.primary,
//             borderRadius: BorderRadius.circular(9),
//           ),
//           alignment: Alignment.center,
//           child: Icon(
//             Icons.add,
//             size: 20,
//             color: UniColor.white,
//           ),
//         ),
//       )
//     ],
//   );
// }

