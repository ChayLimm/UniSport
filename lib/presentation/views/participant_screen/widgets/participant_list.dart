import 'package:flutter/material.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/presentation/views/participant_screen/participant_form_dialog.dart';
import 'package:unitime/presentation/views/participant_screen/widgets/participant_card.dart';

class ParticipantList extends StatelessWidget {
  const ParticipantList({
    super.key,
    required this.participants,
    required this.race,
    required this.onSaved,
  });

  final List<Participant> participants;
  final Race race;
  final void Function(Participant) onSaved;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: participants.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ParticipantCard(
                participant: participants[index],
                onEdit: () async {
                  await showParticipantModalForm(
                    context: context,
                    race: race,
                    participant: participants[index],
                    onSaved: onSaved,
                  );
                },
              ),
            );
          }),
    );
  }
}
