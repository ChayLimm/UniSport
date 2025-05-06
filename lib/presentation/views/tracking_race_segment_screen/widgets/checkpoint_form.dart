import 'package:flutter/material.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';


class CheckpointForm extends StatefulWidget {
  final String bibNumber;
  final DateTime finishTime;
  final List<String> availableBIBs;
  final void Function(String newBib) onSave;

  const CheckpointForm({
    super.key,
    required this.bibNumber,
    required this.finishTime,
    required this.availableBIBs,
    required this.onSave,
  });

  @override
  State<CheckpointForm> createState() => _CheckpointFormState();
}

class _CheckpointFormState extends State<CheckpointForm> {
  late String selectedBib;
  late DateTime finishTime;
  late List<String> availableBIBs; 
  // late String? note;

  @override
  void initState() {
    super.initState();
    selectedBib = widget.bibNumber;
    finishTime = widget.finishTime;
  }

  void onSubmitForm() {
    widget.onSave(selectedBib);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // BIB number dropdown
        DropdownButtonFormField<String>(
          value: selectedBib,
          dropdownColor: UniColor.backGroundColor2,
          decoration: InputDecoration(
            labelText: "BIB Number",
            labelStyle: UniTextStyles.body,
          ),
          items: availableBIBs.map((bib) {
            return DropdownMenuItem(
              value: bib,
              child: Text(bib),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedBib = value;
              });
            }
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
              child: UniButton(
                label: 'Cancel',
                color: UniColor.grayDark,
                onTrigger: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: UniSpacing.m),

            // save/update button
            Expanded(
              child: UniButton(
                label: 'Save',
                color: UniColor.primary,
                onTrigger: onSubmitForm,
              ),
            ),
          ],
        )
      ],
    );
  }
}
