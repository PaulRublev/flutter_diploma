import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:module_data/firebase_options.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class MyFirebaseService implements FirebaseService {
  late final CollectionReference<TrackDb> _tracks;

  @override
  void referenceInit() {
    _tracks =
        FirebaseFirestore.instance.collection('tracks').withConverter<TrackDb>(
              fromFirestore: (snapshot, options) =>
                  TrackDb.fromJson(snapshot.data() ?? {}),
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
  Stream<List<Track>> streamTracks({bool? isDescendent}) {
    return _tracks
        .orderBy('dateTime', descending: isDescendent ?? true)
        .snapshots()
        .map(
          (event) => event.docs.map((e) {
            return e.data().track;
          }).toList(),
        )
        .asBroadcastStream();
  }

  @override
  void addTrack(Track track) {
    _tracks.doc(track.id.toLowerCase()).set(
          TrackDb(
            track: track,
            dateTime: DateTime.now(),
          ),
        );
  }

  @override
  void removeTrack(String trackId) {
    _tracks.doc(trackId.toLowerCase()).delete();
  }
}
