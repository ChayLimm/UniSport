import 'package:unitime/domain/model/checkpoint.dart';

abstract class CheckpointRepository {
  Future<Checkpoint> recordCheckpoint(Checkpoint checkpoint);
  Future<Checkpoint> updateCheckpoint(Checkpoint checkpoint);
  Future<void> deleteCheckpoint(int checkpointID);
  Future<List<Checkpoint>> fetchCheckpointBySegmentId(int segmentID);
  Future<List<Checkpoint>> getAllCheckpoints();
}
