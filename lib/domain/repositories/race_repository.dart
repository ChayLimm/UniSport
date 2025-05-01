
// Now use T instead of the specific model 
// then replace T-type with the specific model when model is implemented


import 'package:unitime/domain/model/race.dart';

abstract class RaceRepository<T>{
  
  // function to get all races 
  Future<List<Race>> getRaces();

  // function to add races
  Future<Race> addRace(Race race);

  // function to get specific race by id 
  Future<Race> getRaceByID(int id);

  // function to update race 
  Future<Race> updateRace(int id, T race);

  // functon to start race by id
  Future<Race> startRace(int id);

  // function to end race by id 
  Future<Race> endRace(int id);

  // function to show participant of each race by race id 
  Future<List<Race>> getParticipantsByRaceID(int id,T race, T participant);
}