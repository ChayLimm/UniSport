import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unitime/data/dto/checkpoint_dto.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/repositories/checkpoing_repository.dart';

class CheckpointImplement extends CheckpointRepository {
  final String baseUrl = 'http://127.0.0.1:8000/api'; // url http for api call


  @override
  Future<void> deleteCheckpoint() {
    // TODO: implement deleteCheckpoint
    throw UnimplementedError();
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
  Future<Checkpoint> updateCheckpoint() {
    // TODO: implement updateCheckpoint
    throw UnimplementedError();
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
