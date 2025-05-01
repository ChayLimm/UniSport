import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/segment.dart';

enum RaceStatus {
  pending("Pending"),
  inProgress("InProgress"),
  completed("Completed");

  final String label;
  const RaceStatus(this.label);
}

///
/// Race class,
///
class Race {
  final int? id; // primary key - optional cuz database will generate auto increas
  final String name;
  final String description;
  final DateTime? startTime;
  final DateTime? endTime;
  final RaceStatus status;
  final DateTime createAt;
  final DateTime updateAt;
  final List<Segment>? segments;
  final List<Participant>? participants;

  Race({
      this.id,
      required this.name,
      required this.description,
      this.startTime,
      this.endTime,
      required this.status,
      required this.createAt,
      required this.updateAt,
      this.segments,
      this.participants});

  // methods
  
}
