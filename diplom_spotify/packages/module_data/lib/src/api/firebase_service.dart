import 'package:module_model/module_model.dart';

abstract class FirebaseService {
  void referenceInit();

  Future firebaseInit();

  Future<List<DatabaseTrack>> getDatabaseTracks();

  Stream<List<DatabaseTrack>> streamDatabaseTracks();

  void addTrack(String trackId);

  void removeTrack(String trackId);
}
