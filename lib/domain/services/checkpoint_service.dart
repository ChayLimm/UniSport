import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/repositories/race_repository.dart';

class CheckpointService {
  RaceRepository? _repository;

  // Store checkpoints mapped by segment ID
  final Map<int, List<Checkpoint>> _segmentCheckpoints = {};

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

  // Method to initialize the singleton instance with repository
  static void initialize(RaceRepository repo) {
    if (_instance == null) {
      _instance = CheckpointService._internal(repo);
    } else {
      throw ("CheckpointService is already initialized");
    }
  }
  
  /// return the checkpoint list for each segment
  List<Checkpoint>? getCheckpointsBySegmentId(int segmentId) {
    return _segmentCheckpoints[segmentId];
  }

  DateTime? getParticipantSegmentTime(int segmentId, int participantId) {
    final checkpoints = getCheckpointsBySegmentId(segmentId);
    if (checkpoints != null) {
      for (var checkpoint in checkpoints) {
        if (checkpoint.participantId == participantId) {
          return checkpoint.checkpointTime;
        }
      }
    }
    return null;
  }
}
