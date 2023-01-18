import 'package:module_model/module_model.dart';

abstract class FirebaseService {
  void referenceInit();

  Future firebaseInit();

  Stream<List<Track>> streamTracks({bool? isDescendent});

  void addTrack(Track track);

  void removeTrack(String trackId);
}
