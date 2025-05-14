import 'package:flutter/material.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/services/checkpoint_service.dart';
import 'package:unitime/presentation/provider/race_provider.dart';

class CheckpointProvider extends ChangeNotifier {
  RaceProvider raceProvider = RaceProvider();
  List<Checkpoint> _checkpoints = [];

  //list all check points
  List<Checkpoint> get checkpoints => _checkpoints;

  void refresh() {
    notifyListeners();
  }

  /// Records a checkpoint using the ELAPSED RACE TIME
  Future<bool> recordCheckpoint({
    required int participantId,
    required int segmentId,
  }) async {
    try {
      final checkpoint = Checkpoint(
        segmentId: segmentId,
        participantId: participantId,
        checkpointTime: DateTime.now(), // to get Actual race time!
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
      );
      print(checkpoint.segmentId);
      final data =
          await CheckpointService.instance.recordCheckpoint(checkpoint);
      print(data);
      _checkpoints.add(checkpoint);
      notifyListeners();
      if (data == null) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // void getCheckpointsBySegmentId(segmentId)async{
  //     final checkpoints = CheckpointService.instance.getCheckpointsBySegmentId(segmentId);
  //     _checkpoints = checkpoints ?? [];
  //     notifyListeners();
  //     return;
  // }

  Future<Checkpoint> updateCheckpoint(Checkpoint checkpoint) async {
    try {
      final response = await CheckpointService.instance.updateCheckpoint(checkpoint);
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteCheckpoint(int checkpointID)async{
    await CheckpointService.instance.deleteCheckpoint(checkpointID);
    
    notifyListeners();
  }

  Checkpoint getParticipantCheckpointTime(int segmentId, int participantId) {
    final checkpoints =
        _checkpoints; //CheckpointService.instance.getCheckpointsBySegmentId(segmentId);
    for (var checkpoint in checkpoints) {
      if (checkpoint.participantId == participantId) {
        return checkpoint;
      }
    }
    return Checkpoint(
        segmentId: 000,
        participantId: 000,
        checkpointTime: DateTime.now(),
        updateAt: DateTime.now(),
        createAt: DateTime.now()); // Return current time if not found
  }

  Future<void> getCheckpointsBySegmentId(int segmentID) async {
    final data =
        await CheckpointService.instance.fetchCheckpointBySegmentId(segmentID);
    _checkpoints.clear();
    _checkpoints.addAll(data);
    print("Fetching checkpoint by segment id🆔 $_checkpoints");
    notifyListeners();
  }

  // function to keep track where a bibnumber is isfinished or not
  bool isCompleted(int segmentId, int participantId) {
    // print(_checkpoints.length);
    final checkpoints = _checkpoints;
    for (var checkpoint in checkpoints) {
      if (checkpoint.participantId == participantId &&
          checkpoint.segmentId == segmentId) {
        return true;
      }
    }
    return false;
  }
}
