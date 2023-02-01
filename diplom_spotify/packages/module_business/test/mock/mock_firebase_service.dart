import 'dart:async';

import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class MockFirebaseService implements FirebaseService {
  List<DatabaseTrack> databaseTracks = [DatabaseTrack(id: 'id', timestamp: 1)];
  final StreamController<List<DatabaseTrack>> _controller = StreamController();

  @override
  void addTrack(String trackId) {
    databaseTracks.add(DatabaseTrack(
        id: trackId, timestamp: DateTime.now().millisecondsSinceEpoch));
    _controller.add(databaseTracks);
  }

  @override
  Future firebaseInit() async {
    return true;
  }

  @override
  void referenceInit() {}

  @override
  void removeTrack(String trackId) {
    databaseTracks.removeWhere((element) => element.id == trackId);
    _controller.add(databaseTracks);
  }

  @override
  Stream<List<DatabaseTrack>> streamDatabaseTracks() {
    _controller.add(databaseTracks);
    return _controller.stream;
  }

  @override
  Future<List<DatabaseTrack>> getDatabaseTracks() async {
    return databaseTracks;
  }
}
