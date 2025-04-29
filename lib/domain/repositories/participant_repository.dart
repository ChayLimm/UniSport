
// Now use T instead of the specific model 
// then replace T-type with the Participant model when model is implemented

import 'package:unitime/domain/model/participant.dart';

abstract class ParticipantRepository{
  
  // Functon to get all participants 
  Future<List<Participant>> getAllParticipants();         // for Get/participants
  
  // funtion to add participant
  Future<Participant> addparticipant(Participant participant);      // for Post/participants

  // function to update participant
  Future<Participant> updateParticipant(String id,Participant participant);  //for put/participants
  
  // function to delete participant 
  Future<Participant> deleteParticipant(String id);      // for Delete/participants
}