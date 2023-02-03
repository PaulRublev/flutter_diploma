import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:test/test.dart';

import 'mock/mock_audio_player.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late Player player;

  setUpAll(() {
    player = Player(audioPlayer: MockAudioPlayer());
  });

  group('Player - initial state: ', () {
    test('trackUri is empty', () {
      expect(player.trackUri, '');
    });
  });

  group('Player: ', () {
    test('set trackUri', () {
      player.setTrackUri('1');
      expect(player.trackUri, '1');
    });
  });
}
