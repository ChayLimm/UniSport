
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart' show Race;
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/domain/repositories/race_repository.dart';
import 'package:unitime/domain/services/checkpoint_service.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';

class RaceService {
  RaceRepository? _repository;
  static RaceService? _instance;
  RaceService._internal(this._repository);


  static RaceService get instance{
  if(_instance == null){
    throw "Must init RaceService";
  }else{
    return _instance!;
  }
 } 

  Future<List<Participant>> getParticipantsByRaceID(int raceID)async{
  try{
    print("start fetching participants for race id : $raceID");
    final data = await _repository!.getParticipantsByRaceID(raceID);
    print("done");
    return data;
  }catch (e){
    rethrow;
  }
 }

  static void initialize(RaceRepository repo) {
    if (_instance == null) {
      _instance = RaceService._internal(repo);
    } else {
      throw("RaceService is already initialized");
    }
  }

  Future<Race> getRaceByID(int raceID)async{
    final race = await _repository!.getRaceByID(raceID);
    return race;
  }

  Future<List<Race>> getRace() async {
   final temp = await _repository!.getRaces();
   return temp;
  }

  void markSegmentFinish(int segmentID)async{
    await _repository!.markSegmentFinish(segmentID);
  }

  int? getStartDuration(DateTime startTime) {
    late Duration duration;
    duration = DateTime.now().difference(startTime!);
      return duration.inMilliseconds;
  }
  void startRace(int raceID){
    _repository!.startRace(raceID);
  }

  void endRace(int raceID){
    _repository!.endRace(raceID);

  }

  Future<List<Segment>> getSegmentByRace(int id) async{
   try{
     final data = await _repository!.getSegmentByRaceID(id);
    return data;}catch (e){
      rethrow;
    }
  }
   

Future<List<ParticipantDuration>> getLeaderBoardForRace(BuildContext context, int id) async {
  final raceProvider = context.read<RaceProvider>();
  final List<Segment> segmentList = raceProvider.currentSegment;
  // check if the race end yet
  Race race = await _repository!.getRaceByID(segmentList.first.raceId);
  if (race.endTime != null) {
    List<Checkpoint> checkpointList = [];
    // fetching all the checkpoint
    print("🐞debug 1");
    final allCheckpoints = await CheckpointService.instance.getAllCheckpoints();
    checkpointList.addAll(allCheckpoints);
  
    //fetch all participant
    final List<Participant> participantList = raceProvider.currentParticipant;
    //

    List<ParticipantDuration> result = [];

    for (Participant participant in participantList) {
      List<DateTime> participantTime = [];

      for (Checkpoint checkpoint in checkpointList) {
        if (checkpoint.participantId == participant.id) {
          participantTime.add(checkpoint.checkpointTime);
        }
      }

      participantTime.sort();
      Duration duration;
      Color? color;
      
      if (participantTime.isEmpty) {
        // No checkpoints - set duration to 0 and color red
        duration = Duration.zero;
        color = UniColor.red;
      } else if (participantTime.length != segmentList.length) {
        // Incomplete race - color yellow
        duration = participantTime.last.difference(race.startTime!);
        color = UniColor.yellow;
      } else {
        // Complete race - color primary
        duration = participantTime.last.difference(race.startTime!);
        color = UniColor.primary;
      }
      
      result.add(ParticipantDuration(
        bibNumber: participant.bibNumber, 
        username: participant.userName,
        duration: duration,
        color: color
      ));
      print("🐞debug 2");
    }

    // Sort by:
    // 1. Complete participants first (sorted by duration)
    // 2. Incomplete participants next (yellow, sorted by duration)
    // 3. No-checkpoint participants last (red)
    result.sort((a, b) {
      // Both have no checkpoints (red)
      if (a.color == UniColor.red && b.color == UniColor.red) {
        return 0; // keep original order
      }
      // Only a has no checkpoints (red)
      else if (a.color == UniColor.red) {
        return 1; // a goes after b
      }
      // Only b has no checkpoints (red)
      else if (b.color == UniColor.red) {
        return -1; // a goes before b
      }
      // Both are yellow or both are not yellow
      else if ((a.color == UniColor.yellow && b.color == UniColor.yellow) || 
          (a.color != UniColor.yellow && b.color != UniColor.yellow)) {
        return a.duration.compareTo(b.duration);
      }
      // One is yellow, the other isn't
      else {
        return a.color == UniColor.yellow ? 1 : -1;
      }
    });

    return result;
  } else {
    return [];
  }
}
}
class ParticipantDuration {
  final String bibNumber;
  final String username;
  final Duration duration;
  final Color? color;

  ParticipantDuration({
    required this.bibNumber,
    required this.username,
    required this.duration,
    this.color = Colors.white, 
  });
}