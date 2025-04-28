
// Now use T instead of the specific model 
// then replace T-type with the Participant model when model is implemented

abstract class ParticipantRepository <T>{
  
  // Functon to get all participants 
  Future<List<T>> getAllParticipants();         // for Get/participants
  
  // funtion to add participant
  Future<T> addparticipant(T participant);      // for Post/participants

  // function to update participant
  Future<T> updateParticipant(String id,T participant);  //for put/participants
  
  // function to delete participant 
  Future<T> deleteParticipant(String id);      // for Delete/participants
}