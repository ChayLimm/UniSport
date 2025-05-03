import 'package:unitime/domain/model/checkpoint.dart';

class CheckpointDto {
  static Map<String, dynamic> toJson(Checkpoint checkpoint) {
    final Map<String, dynamic> data = {
      'id': checkpoint.id,
      'segment_id': checkpoint.segmentId,
      'participant_id': checkpoint.participantId,
      'checkpoint_time': checkpoint.checkpointTime.toIso8601String(),
      'create_at': checkpoint.createAt.toIso8601String(),
      'update_at': checkpoint.updateAt.toIso8601String()
    };
    return data;
  }

  static Checkpoint fromJson(Map<String, dynamic> json) {
    return Checkpoint(
        id: int.tryParse(json['id'])!,
        segmentId: int.tryParse(json['segment_id'])!,
        participantId: int.tryParse(json['participant_id'])!,
        checkpointTime: DateTime.parse(json['checkpoint_time']),
        createAt: DateTime.parse(json['create_at']),
        updateAt: DateTime.parse(json['update_at']));
  }
}
