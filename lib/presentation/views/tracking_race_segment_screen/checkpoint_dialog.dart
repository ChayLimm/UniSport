import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/widgets/checkpoint_form.dart';


Future<void> showDialogModifyCheckpoint({
  required BuildContext context,
  String? currentBib,
  required DateTime finishTime,
  required List<String> filterBIBs,
  required void Function(String newBib) onSaved,
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

          // leading: IconButton(
          //   icon: const Icon(Icons.close),
          //   onPressed: () => Navigator.pop(context),
          // ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(UniSpacing.m),
          child: CheckpointForm(
            bibNumber: currentBib,
            finishTime: finishTime,
            availableBIBs: filterBIBs,
            onSave: (newBib) {
              onSaved(newBib); // Save callback 
            },
            isTwoStepRecord: isTwoStepRecord, // to check if edit / 2 step record bib
          ),
        ),
      ),
    ),
  );
}
