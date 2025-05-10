import 'dart:async';
import 'package:flutter/material.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/domain/services/race_service.dart';

class RaceProvider extends ChangeNotifier {
  int? _elapsedMilliseconds;
  Timer? _timer;

  List<ParticipantDuration> currentLeaderboard = [];
  List<Participant> currentParticipant = [];
  List<Segment> currentSegment = [];
  
  int get elapsedMilliseconds => _elapsedMilliseconds?? 0;
  Future<List<Race>> get racelist => RaceService.instance.getRace();
  Race? seletectedRace;

  Future<void>markSegmentFinish(int segmentID)async{
    RaceService.instance.markSegmentFinish(segmentID);
    for(Segment segment in currentSegment){
      if(segment.id == segmentID){
        segment.markAsFinish = true;
      }
    }
  
  }

  Future<void>startRace(int raceID)async{
      RaceService.instance.startRace(raceID);
      final race = await RaceService.instance.getRaceByID(seletectedRace!.id);
      setRace(race);
      notifyListeners();
  }

  Future<List<Race> >getAllRace()async{
    final result = await RaceService.instance.getRace();
    return result;
  }

  Future<void> getSegmentsByRaceID(int raceID)async{
    currentSegment = await RaceService.instance.getSegmentByRace(raceID);
    notifyListeners();
  }

  Future<void> getParticipantsByRaceID(int raceID)async{
    currentParticipant =  await RaceService.instance.getParticipantsByRaceID(raceID);
    notifyListeners();
  }

  void refresh(){
    notifyListeners();
  }

  Future<void> setRace(Race race)async{
    seletectedRace= race;
    await getParticipantsByRaceID(race.id);
    await getSegmentsByRaceID(race.id);
    notifyListeners();
  }

  void start(DateTime startTime) {
    _timer?.cancel();
    _elapsedMilliseconds = RaceService.instance.getStartDuration(startTime);
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_elapsedMilliseconds != null) {
        _elapsedMilliseconds = _elapsedMilliseconds! + 100;
        notifyListeners();
      } else {
        _elapsedMilliseconds = 0;
        notifyListeners();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }
  Future<void> endRace(int raceID) async {
    RaceService.instance.endRace(raceID);
    stop();
  }

  Future<void> getLeaderBoardForRace(BuildContext context,int id)async{
    final data = await  RaceService.instance.getLeaderBoardForRace(context,id);
    currentLeaderboard = data;
    notifyListeners();
  }


  void reset() {
    _timer?.cancel();
    _elapsedMilliseconds = 0;
    notifyListeners();
  }
  String get formattedTime {
    final int? ms = _elapsedMilliseconds;
    if (ms == null) return "Have not start yet";

    final seconds = (ms / 1000).floor();
    final minutes = (seconds / 60).floor();
    final hours = (minutes / 60).floor();
    final remainingMinutes = minutes % 60;
    final remainingSeconds = seconds % 60;
    final centiseconds = (ms % 1000) ~/ 100;

    return '${_twoDigits(hours)}:${_twoDigits(remainingMinutes)}:${_twoDigits(remainingSeconds)}.${(centiseconds)}';
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
