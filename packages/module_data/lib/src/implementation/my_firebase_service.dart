import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:module_data/firebase_options.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class MyFirebaseService implements FirebaseService {
  late final CollectionReference<DatabaseTrack> _tracks;

  @override
  void referenceInit() {
    _tracks = FirebaseFirestore.instance
        .collection('tracks')
        .withConverter<DatabaseTrack>(
          fromFirestore: (snapshot, options) =>
              DatabaseTrack.fromJson(snapshot.data() ?? {}),
          toFirestore: (track, options) => track.toJson(),
        );
  }

  @override
  Future<FirebaseApp> firebaseInit() async {
    return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<List<DatabaseTrack>> getDatabaseTracks() async {
    final snapshot = await _tracks.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  @override
  Stream<List<DatabaseTrack>> streamDatabaseTracks() {
    return _tracks
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (event) => event.docs.map((e) {
            return e.data();
          }).toList(),
        )
        .asBroadcastStream();
  }

  @override
  void addTrack(String trackId) {
    _tracks.doc(trackId.toLowerCase()).set(
          DatabaseTrack(
            id: trackId,
            timestamp: DateTime.now().millisecondsSinceEpoch,
          ),
        );
  }

  @override
  void removeTrack(String trackId) {
    _tracks.doc(trackId.toLowerCase()).delete();
  }
}
