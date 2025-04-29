
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/race.dart';
import 'package:unitime/domain/repositories/race_repository.dart';
import 'package:http/http.dart' as http;

// still waiting the dto from Vanda fromJson and tojson method

class RaceRepoImpl extends RaceRepository{
  final baseUrl='http://your-domain/api/';
  @override
  Future<List<Participant>> getParticipantsByRaceID(String id, Race race, Participant participant) async{
    final response= await http.post(
      Uri.parse('$baseUrl/{id}/participants'),
      headers: {'Content-Type': 'application/json'},
    );
    if(response.statusCode == 200){
      final List<dynamic> participationsJsonList = jsonDecode(response.body);
      return participationsJsonList.map((json) => Participant.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load participants');
    }
  }
}