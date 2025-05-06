import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart' show Race;
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/domain/repositories/race_repository.dart';
import 'package:unitime/presentation/themes/theme.dart';

class RaceService {
  RaceRepository? _repository;
  static RaceService? _instance;
  RaceService._internal(this._repository);

  static Race? selectedRace;

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
   return temp;
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

  Future<List<ParticipantDuration>> getLeaderBoardForRace(int id) async{
    final List<Segment> segmentList = await getSegmentByRace(id);
    // check if the race end yet
    Race race = await _repository!.getRaceByID(segmentList.first.raceId);
    if(race.endTime!= null ){
       List<Checkpoint> checkpointList = [];
    // fetching all the checkpoint
    for(Segment segment in segmentList){
    final List<Checkpoint> data  = await _repository!.getCheckPointBySegmentID(segment.id!);
     checkpointList.addAll(data);
    }

    //fetch all participant
    final List<Participant> participantList = await _repository!.getParticipantsByRaceID(id);
    //
    List<ParticipantDuration> result = [];

    for(Participant participant in participantList){
      List<DateTime> participantTime = [];
      for(Checkpoint checkpoint in checkpointList){
        if(checkpoint.participantId == participant.id){
          participantTime.add(checkpoint.checkpointTime);
        }

      }
      participantTime.sort();
      Duration duration = participantTime.last.difference(participantTime.first);
      // coloring
      late Color? color;
      if(participantTime.isEmpty){
        color = UniColor.red;
      }
      else if(participantTime.length != segmentList.length){
          color = UniColor.yellow;
      }

      result.add(ParticipantDuration(bibNumber: participant.bibNumber, username: participant.userName,duration: duration,color:color ));

    }

      result.sort((a, b) => a.duration.compareTo(b.duration));

   return result;

    }else{
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