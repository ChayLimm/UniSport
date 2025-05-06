import 'package:unitime/domain/model/segment.dart';

class SegmentDto {
  // convert from segment model to JSON
  static Map<String, dynamic> toJson(Segment segment) {
    final Map<String, dynamic> data = {
      'race_id': segment.raceId,
      'description': segment.description,
      'name': segment.name,
      'orderNumber': segment.orderNumber
    };

    if (segment.id != null) {
      data['id'] = segment.id;
    }
    return data;
  }

  // convert JSON to segment model
  static Segment fromJson(Map<String, dynamic> json) {
    return Segment(
        id: json['id'],
        raceId: int.parse(json['race_id']),
        description: json['description'],
        name: json['name'],
        orderNumber: json['orderNumber'],
        checkpoint: null);
  }

  // for nested with checkpoint
}
