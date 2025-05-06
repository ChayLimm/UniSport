import 'package:flutter/material.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/services/participant_service.dart';


class ParticipantProvider extends ChangeNotifier {
  List<Participant> participantList = [];

  // getter method
  List<Participant> get participants => participantList;

  Future<void> fetchParticipants() async {
    participantList = await ParticipantService.instance.getParticipants();
    notifyListeners();
  }

  Future<void> addParticipant(Participant p) async {
    final newParticipant = await ParticipantService.instance.addParticipant(p);
    participantList.add(newParticipant); // Add the returned participant with id
    notifyListeners(); // Notify UI to update
  }

  Future<void> updateParticipant(Participant p) async {
    final updatedP = await ParticipantService.instance.updateParticipant(p);

    // find index of p in list using id
    final index = participantList.indexWhere((e) => e.id == p.id);
    // check if found updated
    if (index != -1) {
      participantList[index] = updatedP;
      notifyListeners();  // then notify listener to update
    }
  }

  Future<void> deleteParticipant(int id) async {
    await ParticipantService.instance.deleteParticipant(id);
    participantList.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
