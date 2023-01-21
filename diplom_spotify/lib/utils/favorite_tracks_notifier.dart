import 'dart:async';

import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class FavoriteTracksNotifier extends ChangeNotifier {
  List<Track> tracks = [];
  bool isInitialize = false;
  late StreamSubscription _subscription;

  FavoriteTracksNotifier(Stream<List<Track>> stream) {
    // todo try/catch
    _subscription = stream.listen((event) {
      tracks = event;
      isInitialize = true;
      notifyListeners();
    });
  }

  void cancelSubscription() {
    _subscription.cancel();
  }
}
