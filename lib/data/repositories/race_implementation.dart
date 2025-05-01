import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/repositories/race_repository.dart';

class RaceImplementation extends RaceRepository{
  @override
  Future<Race> addRace(Race race) {
    // TODO: implement addRace
    throw UnimplementedError();
  }

  @override
  Future<Race> endRace(int id) {
    // TODO: implement endRace
    throw UnimplementedError();
  }

  @override
  Future<List<Race>> getParticipantsByRaceID(int id, race, participant) {
    // TODO: implement getParticipantsByRaceID
    throw UnimplementedError();
  }

  @override
  Future<Race> getRaceByID(int id) {
    // TODO: implement getRaceByID
    throw UnimplementedError();
  }

  @override
  Future<List<Race>> getRaces() {
    // TODO: implement getRaces
    throw UnimplementedError();
  }

  @override
  Future<Race> startRace(int id) {
    // TODO: implement startRace
    throw UnimplementedError();
  }

  @override
  Future<Race> updateRace(int id, race) {
    // TODO: implement updateRace
    throw UnimplementedError();
  }
  

}