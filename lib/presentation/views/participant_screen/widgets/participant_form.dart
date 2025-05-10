import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/services/participant_service.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';

///
/// Form for add or update participant in race
///
class ParticipantForm extends StatefulWidget {
  final Participant? participant; // add model-null / update-nonNull
  final Race race; // for race id -> create/update
  final Future<void> Function(Participant) onSaveForm;
  const ParticipantForm(
      {super.key,
      this.participant,
      required this.race,
      required this.onSaveForm});

  @override
  State<ParticipantForm> createState() => _ParticipantFormState();
}

class _ParticipantFormState extends State<ParticipantForm> {
  final _formKey = GlobalKey<FormState>();
  late String userName;
  late String bibNumber;
  late String? description;
  late String gender;
  late int age;
  late DateTime registerTime;
  late DateTime createAt;
  late DateTime updateAt;

  @override
  void initState() {
    super.initState();
    // initial value existing / empty
    userName = widget.participant?.userName ?? '';
    bibNumber = widget.participant?.bibNumber ?? '';
    description = widget.participant?.description;
    gender = widget.participant?.gender ?? '';
    age = widget.participant?.age ?? 0;
    registerTime = widget.participant?.registerTime ?? DateTime.now();
    createAt = widget.participant?.createAt ?? DateTime.now();
    updateAt = DateTime.now(); // always update to current time
  }

  // Validator form
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateBibNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'BIB number is required';
    }
    if (value.length > 3) {
      return 'BIB number must be max 3 digits';
    }
    if (int.tryParse(value) == null) {
      return 'BIB number must be numeric';
    }
    return null;
  }

  String? _validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Gender is required';
    }
    if (!['male', 'female', 'other'].contains(value.toLowerCase())) {
      return 'Please enter valid gender (male, female, or other)';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final ageValue = int.tryParse(value);
    if (ageValue == null) {
      return 'Age must be a number';
    }
    if (ageValue < 1 || ageValue > 120) {
      return 'Age must be between 1 and 120';
    }
    return null;
  }
   

  // on submit form
  Future<void> submitForm(BuildContext context) async {
    final raceProvider = context.read<RaceProvider>();
    if(widget.participant == null){
    if (_formKey.currentState!.validate()) {
      // formatted bib number
      final formatBib = 'BIB$bibNumber';
      // Create temp participant with id as null
      final participant = Participant(
        id: widget.participant?.id, // new id will generate in db-auto incresa
        raceId: widget.race.id,
        userName: userName,
        bibNumber: formatBib,
        description: description,
        registerTime: registerTime,
        createAt: widget.participant?.createAt ?? createAt,
        updateAt: updateAt,
        gender: gender,
        age: age,
      );
      // Call onSaveForm callback to trigger API call 
      // await widget.onSaveForm(participant);
      Participant newParticipant = await ParticipantService.instance.addParticipant(participant);
      raceProvider.currentParticipant.add(newParticipant);
      raceProvider.refresh();

    }}else{
      //update
      final originalBib = bibNumber; // or any input
      final formattedBib = originalBib.startsWith('BIB') ? originalBib : 'BIB$originalBib';
      final toUpdateData = Participant(
        id: widget.participant?.id, // new id will generate in db-auto incresa
        raceId: widget.race.id,
        userName: userName,
        bibNumber: formattedBib,
        description: description,
        registerTime: registerTime,
        createAt: widget.participant?.createAt ?? createAt,
        updateAt: updateAt,
        gender: gender,
        age: age,      
      );

      Participant updatedParticipant = await ParticipantService.instance.updateParticipant(toUpdateData);
        print("To update : ${toUpdateData.bibNumber}");

        raceProvider.currentParticipant.add(updatedParticipant);
        raceProvider.currentParticipant.remove(widget.participant);
        raceProvider.refresh();
    }
    return;
  }

  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Full Name field
          TextFormField(
            initialValue: userName,
            decoration: InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter participant name',
              filled: true,
              fillColor: UniColor.black1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UniSpacing.radius),
              ),
              labelStyle: UniTextStyles.body,
              prefixIcon: Icon(Icons.person, color: UniColor.iconLight),
            ),
            style: UniTextStyles.body,
            validator: _validateName,
            onChanged: (value) => userName = value,
          ),
          const SizedBox(height: 16),

          // BIB Number field
          TextFormField(
            initialValue: bibNumber,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
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
            validator: _validateBibNumber,
            onChanged: (value) => bibNumber = value,
          ),
          const SizedBox(height: UniSpacing.m),

          // Gender field
          TextFormField(
            initialValue: gender,
            decoration: InputDecoration(
              labelText: 'Gender',
              hintText: 'Enter gender (male/female/other)',
              filled: true,
              fillColor: UniColor.black1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UniSpacing.radius),
              ),
              labelStyle: UniTextStyles.body,
              prefixIcon: Icon(Icons.people, color: UniColor.iconLight),
            ),
            style: UniTextStyles.body,
            validator: _validateGender,
            onChanged: (value) => gender = value,
          ),
          const SizedBox(height: UniSpacing.m),

          // Age field
          TextFormField(
            initialValue: age != 0 ? age.toString() : '',
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: 'Age',
              hintText: 'Enter age (1-120)',
              filled: true,
              fillColor: UniColor.black1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UniSpacing.radius),
              ),
              labelStyle: UniTextStyles.body,
              prefixIcon: Icon(Icons.cake, color: UniColor.iconLight),
            ),
            style: UniTextStyles.body,
            validator: _validateAge,
            onChanged: (value) => age = int.tryParse(value) ?? 0,
          ),
          const SizedBox(height: UniSpacing.m),

          // Description field (optional)
          TextFormField(
            initialValue: description,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Description (Optional)',
              hintText: 'Add any notes',
              filled: true,
              fillColor: UniColor.black1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UniSpacing.radius),
              ),
              labelStyle: UniTextStyles.body,
              prefixIcon: Icon(Icons.description, color: UniColor.iconLight),
            ),
            style: UniTextStyles.body,
            onChanged: (value) => description = value,
          ),
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
                  label: widget.participant == null ? 'Add' : 'Update',
                  color: UniColor.primary,
                  onTrigger: ()async{
                    await submitForm(context);
                          Navigator.pop(context);
                    },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}