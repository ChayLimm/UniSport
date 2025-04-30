import 'package:unitime/domain/model/race.dart' show Race;
import 'package:unitime/domain/repositories/race_repository.dart';

class RaceService {
  RaceRepository? _repository;
  static RaceService? _instance;
  RaceService._internal(this._repository);

  static Race? seletectedRace;

  static RaceService get instance{
  if(_instance == null){
    throw "Must init RaceService";
  }else{
    return _instance!;
  }
 } 

  static void initialize(RaceRepository repo) {
    if (_instance == null) {
      _instance = RaceService._internal(repo);
    } else {
      throw("RaceService is already initialized");
    }
  }

  Future<List<Race>> getRace() async {
   final temp = await _repository!.getRaces();
   // perform dto for Race
   final List<Race> raceList = [];
   return raceList;
  }

  int? getStartDuration(Race race) {
    late Duration duration;
    if(race.startTime != null){
      duration = DateTime.now().difference(race.startTime!);
    }else{
      return null;
    }
    return duration.inMilliseconds;
  }

  void endRace(int raceID){
    _repository!.endRace(raceID);

  }

}
