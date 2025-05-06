import 'package:unitime/domain/model/race.dart';

class RaceDto {
  // convert race model to json
  static Map<String, dynamic> toJson(Race race) {

    final Map<String, dynamic> data = {
        'name': race.name,
        'description': race.description,
        'start_time': race.startTime?.toIso8601String(),
        'end_time': race.endTime?.toIso8601String(),
        'status': race.status.label,
        'create_at': race.createAt.toIso8601String(),
        'update_at': race.updateAt.toIso8601String(),
    };

    data['id'] = race.id;
  
    return data;
  }

    // convert JSON to race model
    static Race fromJson(Map<String, dynamic> json) {
    DateTime? parseTime(dynamic value) {
      if (value == null) return null;
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value * 1000); // Convert seconds to ms
      }
      if (value is String) {
        return DateTime.tryParse(value);
      }
      throw ArgumentError('Invalid date value: $value');
    }

    return Race(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startTime: parseTime(json['start_time']),
      endTime: parseTime(json['end_time']),
      status: statusFromString(json['status']),
      createAt: parseTime(json['created_at'])!,
      updateAt: parseTime(json['updated_at'] ?? json['created_at'])!, // Fallback if null
      segments: null,
      participants: null,
    );
  }


  // convert string json to enum status race
  static RaceStatus statusFromString(String value) {
    return RaceStatus.values.firstWhere(
      (e) => e.label == value,
      orElse: () => throw ArgumentError('Invalid status: $value'),
    );
  }

  // for nested, race with segment-participant
  // segments: (json['segments'] as List?)?.map((e) => SegmentDto.fromJson(e)).toList(),
  // participants: (json['participants'] as List?)?.map((e) => ParticipantDto.fromJson(e)).toList(),
}


  // static Map<String, dynamic> toJson(Race race) {
  //   return{
  //     'id': race.id ,
  //     'name': race.name,
  //     'description': race.description,
  //     'start_time': race.startTime.toIso8601String(),
  //     'end_time': race.endTime.toIso8601String(),
  //     'status': race.status.label,
  //     'create_at': race.createAt.toIso8601String(),
  //     'update_at': race.updateAt.toIso8601String()
  //   };
  //   // // in case modify, id updae to db still the same
  //   // if (race.id != null) {
  //   // }
  //   // return data;
  // }