import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unitime/data/dto/participant_dto.dart';
import 'package:unitime/data/repositories/base_url.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/repositories/participant_repository.dart';

class ParticipantImplement implements ParticipantRepository {
  final String baseUrl = baseUrl1;//'https://1be5-175-100-11-109.ngrok-free.app/api'; // url http for api call

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
  try {
    final body = json.encode(ParticipantDto.toJson(participant));
    print(body);
    final response = await http.post(
      Uri.parse('$baseUrl/createparticipant'),
      body: body,
      headers: {'Content-Type': 'application/json'},
    );
    print("Respone back : ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ParticipantDto.fromJson(json.decode(response.body));
    } else {
      // Parse the error response if available
      final errorResponse = json.decode(response.body);
      throw Exception(
        'Failed to add participant: ${response.statusCode}\n'
        'Error: ${errorResponse['message'] ?? errorResponse.toString()}'
      );
    }
  } catch (e) {
    throw Exception('Network error: ${e.toString()}');
  }
}

  @override
  Future<Participant> updateParticipant(Participant participant) async {
    final body =json.encode(ParticipantDto.toJson(participant));
    final response = await http.post(
      Uri.parse('$baseUrl/updateparticipant'),
      body: body,
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
