import 'package:unitime/domain/model/checkpoint.dart';

class Participant {
  final int? id; // primary key
  final int raceId; // fk
  final String userName;
  final String bibNumber;
  final String? description;
  final DateTime registerTime;
  final DateTime createAt;
  final DateTime updateAt;
  final List<Checkpoint>? checkpoints;

  Participant({
    this.id, 
    required this.raceId, 
    required this.userName, 
    required this.bibNumber, 
    required this.registerTime, 
    required this.createAt, 
    required this.updateAt, 
    this.description,
    this.checkpoints,
    });
}
