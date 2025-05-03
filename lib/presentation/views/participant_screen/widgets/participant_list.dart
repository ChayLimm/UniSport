import 'package:flutter/material.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/participant_screen/participant_form_dialog.dart';
import 'package:unitime/presentation/views/participant_screen/widgets/participant_card.dart';

class ParticipantList extends StatelessWidget {
  const ParticipantList({
    super.key,
    required this.participants,
    required this.race,
    required this.onSaved,
    required this.onDeleted,
  });

  final List<Participant> participants;
  final Race race;
  final void Function(Participant) onSaved;
  final void Function(Participant) onDeleted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: participants.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(participants[index]
                  .id
                  .toString()), // convert to string for key acceptable
              direction: DismissDirection.endToStart,
              background: _buildBgOnSwipe(),
              onDismissed: (direction) {
                final deletedParticipant = participants[index];
                onDeleted(deletedParticipant);  // call deleteion callback from main participant
              },
              child: Padding(
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
              ),
            );
          }),
    );
  }
}

// custom widget for bg when swipe delete card
Widget _buildBgOnSwipe() {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    color: UniColor.red,
    alignment: Alignment.center,
    padding: EdgeInsets.all(20),
    child: Icon(Icons.delete_rounded, color: UniColor.white),
  );
}
