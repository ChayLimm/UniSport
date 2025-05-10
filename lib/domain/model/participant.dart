import 'package:unitime/domain/model/checkpoint.dart';

class Participant {
  final int? id; // primary key - optional cuz database will generate auto increas when create new
  final int raceId; // fk
  final String userName;
  final String bibNumber;
  final String? description;
  final String gender;
  final int age;
  final DateTime registerTime;
  final DateTime createAt;
  final DateTime updateAt;
  final List<Checkpoint>? checkpoints;

  Participant({
    required this.id, 
    required this.raceId, 
    required this.userName, 
    required this.bibNumber, 
    required this.registerTime, 
    required this.createAt, 
    required this.updateAt, 
    required this.age,
    required this.gender,
    this.description,
    this.checkpoints,
    });
}
