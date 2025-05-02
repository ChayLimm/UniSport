import 'package:flutter/material.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/participant_screen/widgets/participant_form.dart';

/// Show full-screen dialog to add / edit participant
Future<void> showParticipantModalForm({
  required BuildContext context,
  required Race race,
  Participant? participant,
  required void Function(Participant) onSaved,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: UniColor.backGroundColor,
        appBar: AppBar(
          backgroundColor: UniColor.backGroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            participant == null ? 'Add Participant' : 'Edit Participant',
            style: UniTextStyles.heading.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(UniSpacing.m),
            child: SingleChildScrollView(
              child: ParticipantForm(
                race: race,
                participant: participant,
                onSaveForm: (participant) {
                  Navigator.pop(context); // Close full-screen
                  onSaved(participant);
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}







// Future<void> showParticipantDialog({
//   required BuildContext context,
//   required Race race,
//   Participant? participant,
//   required void Function(Participant) onSaved,
// }) async {
//   final result = await showDialog<Participant>(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         insetPadding: EdgeInsets.zero,
//         child: Container(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height,
//           padding: const EdgeInsets.all(16),
//           child: Scaffold(
//             appBar: AppBar(
//               title: Text(participant == null ? 'Add Participant' : 'Edit Participant'),
//               leading: IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//             body: ParticipantForm(
//               race: race,
//               participant: participant,
//             ),
//           ),
//         ),
//       );
//     },
//   );
//   if (result != null) {
//     onSaved(result);
//   }
// }

