
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/repositories/participant_repository.dart';

///
/// This service handles:
/// - Get all participant
/// - Create new participant
/// - Update participant
/// - Delete participant

class ParticipantService {
  // Static private instace
  static ParticipantService? _instance;

  // Access to participant
  final ParticipantRepository repository;

  // private constructor
  ParticipantService._internal(this.repository);

  // initailize
  static void initialize(ParticipantRepository repo) {
    if (_instance == null) {
      _instance = ParticipantService._internal(repo);
    } else {
      throw Exception("ParticipantService is already initailize");
    }
  }

  // singleton accessor
  static ParticipantService get instance {
    if (_instance == null) {
      throw Exception(
          "ParticipantService is not initialize, call initialize()");
    }
    return _instance!;
  }

  // get all participants
  Future<List<Participant>> getParticipants() {
    return repository.getAllParticipants();
  }

  // add new participany
  Future<Participant> addParticipant(Participant p) {
    final result = repository.addparticipant(p);
    return result;
  }

  // update participant by id, with info participant
  Future<Participant> updateParticipant(Participant p) {
    return repository.updateParticipant(p);
  }

  // delete participant by id
  Future<void> deleteParticipant(int pId) {
    return repository.deleteParticipant(pId);
  }
}


// => call in main - dependency inject
// ParticipantService.initialize(ParticipantRepoImpl());