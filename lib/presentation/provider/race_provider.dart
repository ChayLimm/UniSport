import 'dart:async';
import 'package:flutter/material.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/domain/services/race_service.dart';

class RaceProvider extends ChangeNotifier {
  int? _elapsedMilliseconds;
  Timer? _timer;

  int get elapsedMilliseconds => _elapsedMilliseconds?? 0;
  Future<List<Race>> get racelist => RaceService.instance.getRace();

  void start(Race race) {
    _timer?.cancel();

    _elapsedMilliseconds = RaceService.instance.getStartDuration(race);
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_elapsedMilliseconds != null) {
        _elapsedMilliseconds = _elapsedMilliseconds! + 100;
        notifyListeners();
      } else {
        timer.cancel();
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
