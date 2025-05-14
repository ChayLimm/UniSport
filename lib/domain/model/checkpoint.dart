class Checkpoint {
  final int? id; //pk
  final int segmentId;  //fk
  final int? participantId;  //fk 
  final DateTime checkpointTime;
  final DateTime createAt;
  final DateTime updateAt;

  Checkpoint({
    this.id, 
    required this.segmentId, 
     this.participantId, 
    required this.checkpointTime, 
    required this.createAt, 
    required this.updateAt
    });
}
