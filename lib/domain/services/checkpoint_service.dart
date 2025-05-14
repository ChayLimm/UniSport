import 'dart:async';

import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/repositories/checkpoint_repository.dart';

class CheckpointService {
  CheckpointRepository? _repository;

  // Store checkpoints mapped by segment ID
  // final Map<int, List<Checkpoint>> _segmentCheckpoints = {};

  static CheckpointService? _instance;

  CheckpointService._internal(this._repository);

  // Getter to access singleton instance
  static CheckpointService get instance {
    if (_instance == null) {
      throw "Must init CheckpointService";
    } else {
      return _instance!;
    }
  }

  Future<void> deleteCheckpoint(int checkpointID) async{
    await _repository!.deleteCheckpoint(checkpointID);
  }

  Future<Checkpoint> updateCheckpoint(Checkpoint checkpoint) async{
    try{
      final response = await _repository!.updateCheckpoint(checkpoint);
    return response;
    }catch (e){
      rethrow;
    }

  }

  // Method to initialize the singleton instance with repository
  static void initialize(CheckpointRepository repo) {
    if (_instance == null) {
      _instance = CheckpointService._internal(repo);
    } else {
      throw ("CheckpointService is already initialized");
    }
  }
  
  /// return the checkpoint list for each segment
  Future<List<Checkpoint>> fetchCheckpointBySegmentId(int segmentId)async {
    print("start  service ");
    final response = await  _repository!.fetchCheckpointBySegmentId(segmentId);
    print("from service = ${response}");
    return response;
  }

  Future<List<Checkpoint>> getAllCheckpoints()async {
    final response = await  _repository!.getAllCheckpoints();
    return response;
  }


  // DateTime? getParticipantSegmentTime(int segmentId, int participantId) {
  //   final checkpoints = getCheckpointsBySegmentId(segmentId);
  //   if (checkpoints != null) {
  //     for (var checkpoint in checkpoints) {
  //       if (checkpoint.participantId == participantId) {
  //         return checkpoint.checkpointTime;
  //       }
  //     }
  //   }
  //   return null;
  // }

  Future<Checkpoint?> recordCheckpoint(Checkpoint checkpoint)async{
    print({"in service ${checkpoint.segmentId}"});
    final data = await _repository!.recordCheckpoint(checkpoint);
    print({"in service ${checkpoint.segmentId}"});
    return data;
  }
}
