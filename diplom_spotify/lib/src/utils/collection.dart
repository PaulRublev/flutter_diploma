import 'package:diplom_spotify/src/utils/track.dart';
import 'package:flutter/material.dart';

class Collection with ChangeNotifier {
  final Map<String, Track> tracks = {};
  bool isAscending = false;

  void add(Track track) {
    tracks.addAll({track.id: track});
    notifyListeners();
  }

  void remove(String trackId) {
    tracks.remove(trackId);
    notifyListeners();
  }

  void changeSortDirection() {
    isAscending = !isAscending;
    notifyListeners();
  }
}
