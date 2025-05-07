import 'package:unitime/domain/model/participant.dart';

class ParticipantDto {
  // convert model to JSON
  static Map<String, dynamic> toJson(Participant participant) {
    final json = {
      'race_id': participant.raceId,
      'username': participant.userName,
      'bib_number': participant.bibNumber,
      'description': participant.description,
      'register_time': participant.registerTime.toIso8601String(),
      'create_at': participant.createAt.toIso8601String(),
      'update_at': participant.updateAt.toIso8601String(),
      'age' : participant.age,
      'gender' : participant.gender
    };


    json['id'] = participant.id;
    return json;
  }

  // convert JSON to model
  static Participant fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      raceId: int.parse(json['race_id'].toString()), // in case it's a string
      userName: json['username'],
      bibNumber: json['bib_number'],
      registerTime: json['register_time'] != null
          ? DateTime.parse(json['register_time'])
          : DateTime.parse(json['created_at']), // fallback or default
      createAt: DateTime.parse(json['created_at']),
      updateAt: DateTime.parse(json['updated_at']),
      checkpoints: null,
      gender: json['gender'],
      age: json['age'],
    );
  }


  // for nested with checkpoint
}