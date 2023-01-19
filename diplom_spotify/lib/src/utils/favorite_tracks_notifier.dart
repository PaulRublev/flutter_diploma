import 'dart:async';

import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class FavoriteTracksNotifier extends ChangeNotifier {
  List<Track> tracks = [];
  final Stream<Future<List<Track>>> stream;
  late StreamSubscription subscription;

  FavoriteTracksNotifier(this.stream) {
    subscription = stream.listen((event) {
      event.then((value) {
        tracks = value;
        notifyListeners();
      });
    });
  }

  void cancelSubscription() {
    subscription.cancel();
  }
}
