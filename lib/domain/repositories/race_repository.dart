
// Now use T instead of the specific model 
// then replace T-type with the specific model when model is implemented


abstract class RaceRepository<T>{
  
  // function to get all races 
  Future<List<T>> getRaces();

  // function to add races
  Future<T> addRace(T race);

  // function to get specific race by id 
  Future<T> getRaceByID(String id);

  // function to update race 
  Future<T> updateRace(String id, T race);

  // functon to start race by id
  Future<T> startRace(String id);

  // function to end race by id 
  Future<T> endRace(String id);

  // function to show participant of each race by race id 
  Future<List<T>> getParticipantsByRaceID(String id,T race, T participant);
}