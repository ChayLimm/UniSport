import 'package:flutter/material.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/participant_screen/participant_form_dialog.dart';

class ParticipantHeader extends StatelessWidget {
  final List<Participant> participants;
  final Race race;
  final Future<void> Function(Participant) onAdd;

  const ParticipantHeader({
    super.key,
    required this.participants,
    required this.race,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Participants',
          style: UniTextStyles.label.copyWith(
            color: UniColor.grayLight,
            fontWeight: FontWeight.w300,
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            await showParticipantModalForm(
              context: context,
              race: race,
              onSaved: (Participant participant) async {
                print('New participant added: ${participant.userName}');
                await onAdd(participant);
              },
            );
          },
          child: Container(
            width: 40,
            height: 32,
            decoration: BoxDecoration(
              color: UniColor.primary,
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.add,
              size: 20,
              color: UniColor.white,
            ),
          ),
        ),
      ],
    );
  }
}
