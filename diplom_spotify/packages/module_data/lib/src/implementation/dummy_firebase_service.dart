import 'dart:async';

import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class DummyFirebaseService implements FirebaseService {
  List<DatabaseTrack> trackIds = [];
  final StreamController<List<DatabaseTrack>> _controller = StreamController();

  @override
  void addTrack(String trackId) {
    trackIds.add(DatabaseTrack(
        id: trackId, timestamp: DateTime.now().millisecondsSinceEpoch));
    _controller.add(trackIds);
  }

  @override
  Future firebaseInit() async {
    return true;
  }

  @override
  void referenceInit() {}

  @override
  void removeTrack(String trackId) {
    trackIds.removeWhere((element) => element.id == trackId);
    _controller.add(trackIds);
  }

  @override
  Stream<List<DatabaseTrack>> streamTrackIds() {
    _controller.add(trackIds);
    return _controller.stream;
  }
}
