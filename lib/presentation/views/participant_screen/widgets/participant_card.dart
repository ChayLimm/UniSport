import 'package:flutter/material.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/presentation/themes/theme.dart';

class ParticipantCard extends StatelessWidget {
  final Participant participant;
  final VoidCallback onEdit;
  
  const ParticipantCard({
    super.key, 
    required this.participant,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: UniColor.black2,
        borderRadius: BorderRadius.circular(5),
      ),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BIB Number
          Text(
            participant.bibNumber,
            style: UniTextStyles.body.copyWith(
              color: UniColor.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
          
          // Participant Name
          Expanded(
            child: Text(
              participant.userName,
              style: UniTextStyles.body.copyWith(color: UniColor.grayDark),
            ),
          ),
          
          // Edit Button
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(Icons.edit, size: 20, color: UniColor.white),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
