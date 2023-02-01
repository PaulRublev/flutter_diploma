import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late Player player;
  group('Player', () {
    setUp(() {
      player = Player();
    });

    test('initialize', () {
      expect(player.audioPlayer == null, false);
    });

    test('set trackUri', () {
      player.setTrackUri('1');
      expect(player.trackUri, '1');
    });
  });
}
