import 'dart:async';

import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class FavoriteTracksNotifier extends ChangeNotifier {
  List<Track> tracks = [];
  StreamSubscription? subscription;

  FavoriteTracksNotifier(Stream<List<Track>> stream) {
    subscription = stream.listen((event) {
      tracks = event;
      notifyListeners();
    });
  }

  void cancelSubscription() {
    subscription?.cancel();
    subscription = null;
  }
}
