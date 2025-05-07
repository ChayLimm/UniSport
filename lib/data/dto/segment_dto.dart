import 'package:unitime/domain/model/segment.dart';

class SegmentDto {
  // convert from segment model to JSON
  static Map<String, dynamic> toJson(Segment segment) {
      return {
        'id': segment.id,
        'race_id': segment.raceId,
        'description': segment.description,
        'name': segment.name,
        'orderNumber': segment.orderNumber,
        'mark_as_finish' : segment.markAsFinish
      };
    }

  // convert JSON to segment model
  static Segment fromJson(Map<String, dynamic> json) {
    return Segment(

        id: json['id'],
        raceId: int.parse(json['race_id']),
        description: json['description'],
        name: json['name'],
        orderNumber: json['orderNumber'],
        checkpoint: null,
        markAsFinish: json['mark_as_finish']
        );
  }

  // for nested with checkpoint
}
