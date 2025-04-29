import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchProvider extends ChangeNotifier {
  int _elapsedMilliseconds = 0;
  Timer? _timer;

  int get elapsedMilliseconds => _elapsedMilliseconds;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _elapsedMilliseconds += 100;
      notifyListeners();
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void reset() {
    _timer?.cancel();
    _elapsedMilliseconds = 0;
    notifyListeners();
  }

String get formattedTime {
  final seconds = (_elapsedMilliseconds / 1000).floor();
  final minutes = (seconds / 60).floor();
  final hours = (minutes / 60).floor();
  final remainingMinutes = minutes % 60;
  final remainingSeconds = seconds % 60;
  final centiseconds = (_elapsedMilliseconds % 1000) ~/ 10; // 00-99 (not 0-9)

  return '${_twoDigits(hours)}:${_twoDigits(remainingMinutes)}:${_twoDigits(remainingSeconds)}.${_twoDigits(centiseconds)}';
}
  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
