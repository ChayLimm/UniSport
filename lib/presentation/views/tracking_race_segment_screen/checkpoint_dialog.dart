import 'package:flutter/material.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/widget/checkpoint_form.dart';


Future<void> showDialogModifyCheckpoint({
  required BuildContext context,
  Participant? selectedParticipant,
  required Duration duration,
  required Checkpoint checkpoint,
  required List<String> filterBIBs,
  required Segment segment,
  bool isTwoStepRecord = false  
}) async {
  await showDialog(
    context: context,
    builder: (_) => Dialog.fullscreen(
      child: Scaffold(
        backgroundColor: UniColor.backGroundColor,
        appBar: AppBar(
          backgroundColor: UniColor.backGroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            isTwoStepRecord ? 'Record BIB' : 'Edit Finished BIB',
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
        body: Padding(
          padding: const EdgeInsets.all(UniSpacing.m),
          child: CheckpointForm(
            segment: segment,
            selectedParticipant: selectedParticipant,
            duration: duration,
            isTwoStepRecord: isTwoStepRecord, 
            checkpoint: checkpoint, // to check if edit / 2 step record bib
          ),
        ),
      ),
    ),
  );
}
