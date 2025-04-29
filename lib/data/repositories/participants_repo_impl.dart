import 'dart:convert';

import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/repositories/participant_repository.dart';
import 'package:http/http.dart'as http;

// i am still waiting the dto from Vanda fromJson and tojson method 

class ParticipantsRepoImpl extends ParticipantRepository{
  final baseUrl='http://your-domain/api/';
  
  @override
  Future<Participant> addparticipant(Participant participant) async {
    final response = await http.post(
      Uri.parse('$baseUrl/participant'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(participant.toJson()),
    );

    if (response.statusCode == 200) {
      return Participant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create participant');
    }
  }

  @override
  Future<Participant> deleteParticipant(String id) async{
    final response= await http.delete(
      Uri.parse('$baseUrl/participant/{id}'),
      headers: {'Content-Type': 'application/json'},
    );
    if(response.statusCode == 200){
      return Participant.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to delete participant');
    }
  }

  @override
  Future<List<Participant>> getAllParticipants() async{
    final response= await http.get(
      Uri.parse('$baseUrl/participants'),
      headers: {'Content-Type': 'application/json'},
    );
    if(response.statusCode ==200){
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Participant.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load participants');
    }
  }

  @override
  Future<Participant> updateParticipant(String id, Participant participant) async{
    final response= await http.put(
      Uri.parse('$baseUrl/participant/{id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(participant.toJson()),
    );
    if(response.statusCode == 200){
      return Participant.fromJson(jsonDecode(response.body));
    }else{  
      throw Exception('Failed to update participant');
    }
  }

}