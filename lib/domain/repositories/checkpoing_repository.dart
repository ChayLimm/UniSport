import 'package:unitime/domain/model/checkpoint.dart';

abstract class CheckpointRepository {
  Future<Checkpoint> recordCheckpoint(Checkpoint checkpoint);
  Future<Checkpoint> updateCheckpoint();
  Future<void> deleteCheckpoint();
  Future<List<Checkpoint>> fetchCheckpointBySegmentId(int segmentID);
  Future<List<Checkpoint>> getAllCheckpoints();
}
