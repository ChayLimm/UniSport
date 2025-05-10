import 'package:unitime/domain/model/checkpoint.dart';

class CheckpointDto {
  static Map<String, dynamic> toJson(Checkpoint checkpoint) {
    final Map<String, dynamic> data = {
      'id': checkpoint.id,
      'segment_id': checkpoint.segmentId,
      'participant_id': checkpoint.participantId,
      'checkpoint_time': checkpoint.checkpointTime.toIso8601String(),
      'created_at': checkpoint.createAt.toIso8601String(),
      'updated_at': checkpoint.updateAt.toIso8601String()
    };


    data['id'] = checkpoint.id;
    return data;
  }

  static Checkpoint fromJson(Map<String, dynamic> json) {
    return Checkpoint(
        id: json['id'],
        segmentId: int.parse(json['segment_id'].toString()),
        participantId: int.parse(json['participant_id'].toString()),
        checkpointTime:DateTime.parse(json['created_at']), //DateTime.fromMillisecondsSinceEpoch(json['checkpoint_time'] * 1000), // Convert seconds → milliseconds
        createAt: DateTime.parse(json['created_at']),
        updateAt: DateTime.parse(json['updated_at']));
  }
}
