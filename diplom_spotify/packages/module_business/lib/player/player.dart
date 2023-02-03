import 'package:just_audio/just_audio.dart';

export 'package:just_audio/just_audio.dart';

class Player {
  Player({AudioPlayer? audioPlayer})
      : audioPlayer = audioPlayer ?? AudioPlayer();

  final AudioPlayer audioPlayer;
  String trackUri = '';

  void setTrackUri(String uri) {
    if (uri != trackUri) {
      trackUri = uri;
      audioPlayer.pause();

      audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(uri),
      ));
    }
  }

  Stream<PlayerState>? get playerStateStream {
    return audioPlayer.playerStateStream.asBroadcastStream();
  }

  void stopIfDeleted(String uri) {
    if (uri == trackUri) {
      audioPlayer.pause();
    }
  }

  void dispose() {
    audioPlayer.dispose();
  }
}
