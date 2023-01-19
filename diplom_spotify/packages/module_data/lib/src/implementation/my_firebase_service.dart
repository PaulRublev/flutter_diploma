import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:module_data/firebase_options.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  Stream<Future<List<Track>>> streamTracks() {
    return streamTrackIds().map((event) async {
      final trackIdsString =
          event.toString().replaceAll(RegExp(r'([\[\]\s])'), '');
      if (trackIdsString == '') {
        return [];
      }
      // todo string to const
      final uri = "https://api.napster.com/v2.2/tracks/$trackIdsString"
          "?apikey=ZThhYzkwNDItODczNC00MWZlLTgxODUtZWExNDQ2YTYyNGY0";

      return await _getTracklist(uri);
    });
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

Future<List<Track>> _getTracklist(String uri) async {
  final url = Uri.parse(uri);
  var rawData = await httpGetAndDecode(url) as Map<String, dynamic>;
  List<dynamic> data = rawData['tracks'];
  return data.map((artist) => Track.fromJson(artist)).toList();
}

dynamic httpGetAndDecode(Uri uri) async {
  final response = await http.get(uri);
  return json.decode(response.body);
}
