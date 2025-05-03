import 'package:unitime/domain/model/checkpoint.dart';

class Segment {
  final int id; // primary key
  final int raceId; // fk
  final String description; // for distance in each segment
  final String name;
  final int orderNumber;
  final Checkpoint? checkpoint;

  Segment({
    required this.id, 
    required this.raceId, 
    required this.description, 
    required this.name, 
    required this.orderNumber, 
    this.checkpoint
    });

}
