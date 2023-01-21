import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:module_data/firebase_options.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class MyFirebaseService implements FirebaseService {
  late final CollectionReference<TrackId> _tracks;

  @override
  void referenceInit() {
    _tracks =
        FirebaseFirestore.instance.collection('tracks').withConverter<TrackId>(
              fromFirestore: (snapshot, options) =>
                  TrackId.fromJson(snapshot.data() ?? {}),
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
  Stream<List<TrackId>> streamTrackIds() {
    return _tracks
        .orderBy('duration', descending: true)
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
          TrackId(
            id: trackId,
            duration: DateTime.now().millisecondsSinceEpoch,
          ),
        );
  }

  @override
  void removeTrack(String trackId) {
    _tracks.doc(trackId.toLowerCase()).delete();
  }
}
