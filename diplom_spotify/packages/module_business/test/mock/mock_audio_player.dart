import 'package:mocktail/mocktail.dart';
import 'package:module_business/module_business.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {
  @override
  Future<Duration?> setAudioSource(
    AudioSource source, {
    bool preload = true,
    int? initialIndex,
    Duration? initialPosition,
  }) async {
    return const Duration(seconds: 30);
  }

  @override
  Future<void> pause() async {}
}
