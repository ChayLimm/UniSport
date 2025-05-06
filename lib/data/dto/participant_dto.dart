import 'package:unitime/domain/model/participant.dart';

class ParticipantDto {
  // convert model to JSON
  static Map<String, dynamic> toJson(Participant participant) {
    final Map<String, dynamic> data = {
      'race_id': participant.raceId,
      'username': participant.userName,
      'bib_number': participant.bibNumber,
      'description': participant.description?.toString(),
      'register_time': participant.registerTime.toIso8601String(),
      'create_at': participant.createAt.toIso8601String(),
      'update_at': participant.updateAt.toIso8601String()
    };

    data['id'] = participant.id;
      return data;
  }

  // convert JSON to model
  static Participant fromJson(Map<String, dynamic> json) {
    return Participant(
        id: json['id'],
        raceId: int.parse(json['race_id']),
        userName: json['username'],
        bibNumber: json['bib_number'],
        registerTime: DateTime.parse(json['register_time']),
        createAt: DateTime.parse(json['create_at']),
        updateAt: DateTime.parse(json['update_at']),
        checkpoints: null);
  }

  // for nested with checkpoint
}
