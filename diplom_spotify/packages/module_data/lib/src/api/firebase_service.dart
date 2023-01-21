import 'package:module_model/module_model.dart';

abstract class FirebaseService {
  void referenceInit();

  Future firebaseInit();

  Stream<List<TrackId>> streamTrackIds();

  void addTrack(String trackId);

  void removeTrack(String trackId);
}