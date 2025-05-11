import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';

class CheckpointForm extends StatefulWidget {
  final String? bibNumber; // nullable for unknown bib (2 step record)
  final DateTime finishTime;
  final List<String> availableBIBs;
  final void Function(String newBib) onSave;
  final bool isTwoStepRecord; // toggle flag for check if 2 step

  const CheckpointForm({
    super.key,
    this.bibNumber,
    required this.finishTime,
    required this.availableBIBs,
    required this.onSave,
    this.isTwoStepRecord = false, // defualt for edit checkpoint
  });

  @override
  State<CheckpointForm> createState() => _CheckpointFormState();
}

class _CheckpointFormState extends State<CheckpointForm> {
  late String? selectedBib;
  late DateTime finishTime;
  final TextEditingController _bibController = TextEditingController();
  // late List<String> availableBIBs;
  // late String? note;

  @override
  void initState() {
    super.initState();
    finishTime = widget.finishTime;

    // Initialize bib based on form type: edit/2step
    if (widget.isTwoStepRecord) {
      selectedBib = null;
    } else {
      selectedBib = widget.bibNumber;
      if (selectedBib != null) {
        _bibController.text = selectedBib!;
      }
    }
  }

  @override
  void dispose() {
    _bibController.dispose();
    super.dispose();
  }

  void onSubmitForm() {
    if (widget.isTwoStepRecord) {
      // Use text from for 2-step record
      selectedBib = _bibController.text;
    }
    if (selectedBib != null && selectedBib!.isNotEmpty) {
      widget.onSave(selectedBib!);
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
            : DropdownButtonFormField<String>(
                value: selectedBib,
                dropdownColor: UniColor.backGroundColor2,
                decoration: InputDecoration(
                  labelText: "BIB Number",
                  labelStyle: UniTextStyles.body,
                ),
                items: widget.availableBIBs.map((bib) {
                  return DropdownMenuItem(
                    value: bib,
                    child: Text(bib),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBib = value;
                  });
                },
                style: UniTextStyles.body,
              ),
        const SizedBox(height: UniSpacing.l),

        // Finish Time
        TextFormField(
          initialValue: finishTime.toIso8601String(),
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
                  label: 'Cancel',
                  color: UniColor.grayDark,
                  onTrigger: () => Navigator.pop(context),
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
