import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unitime/data/dto/participant_dto.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/repositories/participant_repository.dart';

class ParticipantImplement implements ParticipantRepository {
  final String baseUrl = ''; // url http for api call

  @override
  Future<List<Participant>> getAllParticipants() async {
    final response = await http.get(Uri.parse('$baseUrl/participant'));
    if (response.statusCode == 200) {
      // Convert JSON string response to List of JSON maps
      final List<dynamic> jsonList = json.decode(response.body);
      // Convert each JSON map into a Participant model
      return jsonList.map((e) => ParticipantDto.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load participants');
    }
  }

  @override
  Future<Participant> addparticipant(Participant participant) async {
    final response = await http.post(Uri.parse('$baseUrl/participant'),
        body: json.encode(ParticipantDto.toJson(participant)),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return ParticipantDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add new participant');
    }
  }

  @override
  Future<Participant> updateParticipant(Participant participant) async {
    final response = await http.put(
      Uri.parse('$baseUrl/participant/${participant.id}'),
      body: json.encode(ParticipantDto.toJson(participant)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ParticipantDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update participant');
    }
  }

  @override
  Future<void> deleteParticipant(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/participants/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete participant');
    }
  }
}
