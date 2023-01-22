import 'package:just_audio/just_audio.dart';

class Player {
  AudioPlayer? audioPlayer;
  String trackUri = '';

  void initialize() {
    audioPlayer ??= AudioPlayer();
  }

  void setTrackUri(String uri) {
    if (uri != trackUri) {
      trackUri = uri;
      audioPlayer?.pause();
      if (audioPlayer != null) {
        audioPlayer?.setAudioSource(AudioSource.uri(
          Uri.parse(uri),
        ));
      }
    }
  }

  Stream<PlayerState>? get playerStateStream {
    return audioPlayer?.playerStateStream.asBroadcastStream();
  }

  void stopIfDeleted(String uri) {
    if (uri == trackUri) {
      audioPlayer?.pause();
    }
  }

  void dispose() {
    audioPlayer?.dispose();
  }
}
