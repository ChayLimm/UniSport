import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unitime/data/dto/checkpoint_dto.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/repositories/checkpoint_repository.dart';

class CheckpointImplement extends CheckpointRepository {
  final String baseUrl = 'http://127.0.0.1:8000/api'; // url http for api call


  @override
  Future<void> deleteCheckpoint(int checkpointID)async {
    // TODO: implement deleteCheckpoint
     await  http.delete(
        Uri.parse('$baseUrl/checkpoint/$checkpointID'),
        headers: {'Content-Type': 'application/json'},
      );
  }

  @override
  Future<Checkpoint> recordCheckpoint(Checkpoint checkpoint) async {
    // TODO: implement recordCheckpoint
    try {
      final body = CheckpointDto.toJson(checkpoint);
      final endCoded = jsonEncode(body);
      print(endCoded);
      final response = await http.post(
        Uri.parse('$baseUrl/checkpoint'),
        body: endCoded,
        headers: {'Content-Type': 'application/json'},
      );
      final data = jsonDecode(response.body);
      print(data);
      final result = CheckpointDto.fromJson(data);
      print(result.participantId);
      return result;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Checkpoint> updateCheckpoint(Checkpoint checkpoint) async {
    // TODO: implement updateCheckpoint
     try {
      final body = CheckpointDto.toJson(checkpoint);
      final endCoded = jsonEncode(body);
      print("endcoded data = ${endCoded}");
      final response = await http.put(
        Uri.parse('$baseUrl/checkpoint'),
        body: endCoded,
        headers: {'Content-Type': 'application/json'},
      );
      final data = jsonDecode(response.body);
      final result = CheckpointDto.fromJson(data);
      print(result.participantId);
      return result;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Checkpoint>> fetchCheckpointBySegmentId(int segmentID) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/checkpoint/$segmentID/segment'));
      final data = jsonDecode(response.body) as List;
       final result = data.map((e) => CheckpointDto.fromJson(e)).toList();
      print("done implementation ${result.first.checkpointTime}");
      return result;
    } catch (e) {
      throw "$e";
    }
  }
  
  @override
  Future<List<Checkpoint>> getAllCheckpoints()async {
   try {
      final response = await http.get(Uri.parse('$baseUrl/checkpoint'));
      final data = jsonDecode(response.body) as List;
       final result = data.map((e) => CheckpointDto.fromJson(e)).toList();
      // print("done implementation ${result.first.checkpointTime}");
      return result;
    } catch (e) {
      throw "Error in fecthing all checkpoints ${e}";
    }
  }


}
