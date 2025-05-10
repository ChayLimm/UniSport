import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unitime/data/dto/checkpoint_dto.dart';
import 'package:unitime/data/dto/participant_dto.dart';
import 'package:unitime/data/dto/race_dto.dart';
import 'package:unitime/data/dto/segment_dto.dart';
import 'package:unitime/data/repositories/base_url.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/repositories/race_repository.dart';


// const String baseUrl = "https://1be5-175-100-11-109.ngrok-free.app/api"; // Replace with your actual base URL

class RaceImplementation extends RaceRepository {
  final String baseUrl = baseUrl1;//'https://1be5-175-100-11-109.ngrok-free.app/api'; // url http for api call
  // Fetch all races
  @override
  Future<List<Race>> getRaces() async {
    final response = await http.get(Uri.parse('$baseUrl/race'));
    if (response.statusCode == 200) {
      print("fecting form cloud ${response.body}");
      final decoded = jsonDecode(response.body);
      final List<dynamic> data = decoded['data'];     
      print(data);
      List<Race> result = data.map((e) => RaceDto.fromJson(e)).toList();
      print("done : $result");
      return result; // Use RaceDto to parse

    } else {
      throw Exception("Failed to load races");
    }
  }
  @override
  // Fetch segments by race ID
  Future<List<Segment>> getSegmentByRaceID(int raceId) async {
    final response = await http.post(Uri.parse('$baseUrl/race/$raceId/segments'));
        
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Segment> result = (data as List)
          .map((e) => SegmentDto.fromJson(e as Map<String, dynamic>))
          .toList();
      return result;
    } else {
      throw Exception("Failed to load segments");
    }
  }
  @override
  // Fetch checkpoints by segment ID
  Future<List<Checkpoint>> getCheckPointBySegmentID(int segmentId) async {
    final response = await http.get(Uri.parse('$baseUrl/segments/$segmentId/checkpoint'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => CheckpointDto.fromJson(e)).toList(); // Use CheckpointDto to parse
    } else {
      throw Exception("Failed to load checkpoints");
    }
  }
  @override
  // Fetch participants by race ID
  Future<List<Participant>> getParticipantsByRaceID(int raceId) async {
    final response = await http.post(Uri.parse('$baseUrl/race/$raceId/participant'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ParticipantDto.fromJson(e)).toList(); // Use ParticipantDto to parse
    } else {
      throw Exception("Failed to load participants");
    }
  }
  @override
  // Start race
  Future<void> startRace(int id) async {
    final response = await http.post(Uri.parse('$baseUrl/race/$id/startRace'));
    if (response.statusCode != 200) {
      throw Exception("Failed to start race");
    }
  }
  @override
  // End race
  Future<void> endRace(int id) async {
    final response = await http.post(Uri.parse('$baseUrl/race/$id/endRace'));
    if (response.statusCode != 200) {
      throw Exception("Failed to end race");
    }
  }
  @override
  Future<Race> getRaceByID(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/race/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Race result =  RaceDto.fromJson(data);
      return result; // Use RaceDto to parse

    } else {
      throw Exception("Failed to load races");
    }
  }
  
  @override
  Future<void> markSegmentFinish(int segmentID) async {
    // TODO: implement markSegmentFinish
    await http.post(Uri.parse('$baseUrl/race/$segmentID/segments-finish'));
    return;
  }
    
}
