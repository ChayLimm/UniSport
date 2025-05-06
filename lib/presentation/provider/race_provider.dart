import 'dart:async';
import 'package:flutter/material.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/services/race_service.dart';

class RaceProvider extends ChangeNotifier {
  int? _elapsedMilliseconds;

  Timer? _timer;

  List<ParticipantDuration> currentLeaderboard = [];

  int get elapsedMilliseconds => _elapsedMilliseconds?? 0;
  Future<List<Race>> get racelist => RaceService.instance.getRace();
  Race? seletectedRace;

  Future<List<Race> >getAllRace()async{
    final result = await RaceService.instance.getRace();
    return result;
  }

  

  void setRace(Race race){
    seletectedRace= race;
    notifyListeners();
  }

  void start(Race race) {
    _timer?.cancel();

    _elapsedMilliseconds = RaceService.instance.getStartDuration(race);
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_elapsedMilliseconds != null) {
        _elapsedMilliseconds = _elapsedMilliseconds! + 100;
        notifyListeners();
      } else {
        _elapsedMilliseconds = 0;
        RaceService.instance.startRace(race.id);
        notifyListeners();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }
  Future<void> endRace(int raceID) async {
    //check each segment end yet?
    // List<Segment> segmentList = SegmentService.instance.getSegment(raceID);
    // for(Segment segment in segmentList){
    //   if(segment.)
    // }
    RaceService.instance.endRace(raceID);
    stop();
  }

  Future<void> getLeaderBoardForRace(int id)async{
    final data = await  RaceService.instance.getLeaderBoardForRace(id);
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
