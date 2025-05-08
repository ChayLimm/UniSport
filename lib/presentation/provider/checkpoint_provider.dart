import 'package:flutter/material.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/services/checkpoint_service.dart';
import 'package:unitime/domain/services/race_service.dart';
import 'package:unitime/presentation/provider/race_provider.dart';

class CheckpointProvider extends ChangeNotifier {
  RaceProvider raceProvider=RaceProvider();
  List<Checkpoint> _checkpoints = [];
  
  //list all check points
  List<Checkpoint> get checkpoints => _checkpoints;

  /// Records a checkpoint using the ELAPSED RACE TIME
  Future<void> recordCheckpoint({
    required int participantId,
    required int segmentId,
  }) async {
    final race = RaceService.selectedRace;
    if (race == null || race.startTime == null) {
      throw Exception("Race not started or no race selected");
    }

    // function to calculate checkpoint time: Race start + elapsed duration
    final elapsedMs = RaceService.instance.getStartDuration(race) ?? 0;
    final checkpointTime = race.startTime!.add(Duration(milliseconds: elapsedMs));

    final checkpoint = Checkpoint(
      id: 1, // Temporary ID 
      segmentId: segmentId,
      participantId: participantId,
      checkpointTime: checkpointTime, // to get Actual race time!
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
    );

    _checkpoints.add(checkpoint);
    notifyListeners();
  }

  DateTime getParticipantCheckpointTime(int segmentId, int participantId) {
    final checkpoints = CheckpointService.instance.getCheckpointsBySegmentId(segmentId);
    if (checkpoints != null) {
      for (var checkpoint in checkpoints) {
        if (checkpoint.participantId == participantId) {
          return checkpoint.checkpointTime;
        }
      }
    }
    return DateTime.now(); // Return current time if not found
  }

  // function to keep track where a bibnumber is isfinished or not 
  bool isCompleted(int segmentId, int participantId) {
    final checkpoints = CheckpointService.instance.getCheckpointsBySegmentId(segmentId);
    if (checkpoints != null) {
      for (var checkpoint in checkpoints) {
        if (checkpoint.participantId == participantId) {
          return true;
        }
      }
    }
    return false;
  }
}