import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/presentation/provider/checkpoint_provider.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/tracking_segment_screen.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';
import 'package:unitime/presentation/widgets/custom_snackbar.dart';
import 'package:unitime/utils/formatter.dart';

class CheckpointForm extends StatefulWidget {
  final Participant? selectedParticipant; // nullable for unknown bib (2 step record)
  final Checkpoint checkpoint;
  final Duration duration;
  final Segment segment;
  final bool isTwoStepRecord; // toggle flag for check if 2 step

  const CheckpointForm({
    super.key,
    this.selectedParticipant,
    required this.duration,
    this.isTwoStepRecord = false, // defualt for edit checkpoin
    required this.checkpoint,
    required this.segment
  });

  @override
  State<CheckpointForm> createState() => _CheckpointFormState();
}

class _CheckpointFormState extends State<CheckpointForm> {
  late Participant? selectedParticipant;
  late Duration duration;
  List<Participant> unfinishParticipant = [];

  final TextEditingController _bibController = TextEditingController();
  // late List<String> availableBIBs;
  late String formattedDuration;

  Future<Checkpoint> _onSave(Checkpoint checkpoint) async{
    // perform saving logic using Service
    final checkpointProvider = context.read<CheckpointProvider>();
    final response = await checkpointProvider.updateCheckpoint(checkpoint);
    return response;
  }

  @override
  void initState() {
    super.initState();
    final raceProvider = context.read<RaceProvider>();
    formattedDuration = formatDuration(widget.duration);

    // Initialize bib based on form type: edit/2step
    if (widget.isTwoStepRecord) {
      selectedParticipant = null;
    } else {
      selectedParticipant = widget.selectedParticipant;
      if (selectedParticipant != null) {
        _bibController.text = selectedParticipant?.bibNumber ?? "none";
      }
    }

     //unfinish participants
    final checkpointProvider = context.read<CheckpointProvider>();
    for(Participant participant in raceProvider.currentParticipant){
      final checkpoint = checkpointProvider.getParticipantCheckpointTime(
        widget.checkpoint.segmentId,
        participant.id!,
      );
      if(checkpoint.participantId == 0){
        unfinishParticipant.add(participant);
      }
    }
  }

  @override
  void dispose() {
    _bibController.dispose();
    super.dispose();
  }

  void onSubmitForm() async {
    final raceProvider = Provider.of<RaceProvider>(context,listen: false);
    if (widget.isTwoStepRecord) {
      // Use text from for 2-step record
    }
    if (selectedParticipant != null) {
      // create a new checkpoint to update
      Checkpoint newCheckpoint  = Checkpoint(
        id: widget.checkpoint.id,
        segmentId: widget.checkpoint.segmentId, 
        participantId:  selectedParticipant!.id!, // catch the new participant id from the input 
        checkpointTime: widget.checkpoint.checkpointTime, 
        createAt: widget.checkpoint.createAt, 
        updateAt: widget.checkpoint.updateAt
        );
      final response = await _onSave(newCheckpoint);
      UniSportSnackbar.show(
        context: context,
        message: "Update succesfully",
        backgroundColor: UniColor.primary
      );
      raceProvider.setRace(raceProvider.seletectedRace!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {


   

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // BIB number input (dropdown / textfiled)
        widget.isTwoStepRecord
            ? TextFormField(
                controller: _bibController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'BIB Number',
                  hintText: 'Enter 3-digit number',
                  filled: true,
                  fillColor: UniColor.black1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(UniSpacing.radius),
                  ),
                  labelStyle: UniTextStyles.body,
                  prefixIcon: Icon(Icons.confirmation_number, color: UniColor.iconLight),
                ),
                style: UniTextStyles.body,
              )
            : DropdownButtonFormField<Participant>(
                value: unfinishParticipant.contains(selectedParticipant) ? selectedParticipant : null,
                dropdownColor: UniColor.backGroundColor2,
                decoration: InputDecoration(
                  labelText: "BIB Number",
                  labelStyle: UniTextStyles.body,
                ),
                items: unfinishParticipant.map((participant) {
                  return DropdownMenuItem<Participant>(
                    value: participant,
                    child: Text(participant.bibNumber),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedParticipant = value;
                  });
                },
          style: UniTextStyles.body,
        ),

        const SizedBox(height: UniSpacing.l),

        // Finish Time
        TextFormField(
          enabled: false,
          initialValue: formattedDuration,
          readOnly: true, // for only read
          decoration: InputDecoration(
            labelText: 'Finish Time',
            labelStyle: UniTextStyles.body,
          ),
          style: UniTextStyles.body,
        ),
        const SizedBox(height: UniSpacing.m),

        // // Optional Note
        // TextFormField(
        //   initialValue: note,
        //   maxLines: 3,
        //   decoration: InputDecoration(
        //     labelText: 'Note (optional)',
        //     hintText: 'Add comment for audit/fix',
        //     labelStyle: UniTextStyles.body,
        //   ),
        //   style: UniTextStyles.body,
        //   onChanged: (value) => note = value,
        // ),
        const SizedBox(height: UniSpacing.xl),

        // Submit buttons section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cancel button
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: UniButton(
                  label: 'Untrack',
                  color: UniColor.red,
                  onTrigger: ()async{
                    final checkpointProvider= context.read<CheckpointProvider>();
                    await checkpointProvider.deleteCheckpoint(widget.checkpoint.id!);
                    Navigator.pop(context);
                    
                   },
                ),
              ),
            ),
            const SizedBox(width: UniSpacing.m),

            // save/update button
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: UniButton(
                  label: 'Save',
                  color: UniColor.primary,
                  onTrigger: onSubmitForm,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
