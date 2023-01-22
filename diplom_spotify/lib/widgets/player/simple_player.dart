import 'package:diplom_spotify/widgets/player/custom_slider.dart';
import 'package:diplom_spotify/widgets/player/player_button.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:module_model/module_model.dart';

class SimplePlayer extends StatefulWidget {
  final Track track;

  const SimplePlayer({super.key, required this.track});

  @override
  State<SimplePlayer> createState() => _SimplePlayerState();
}

class _SimplePlayerState extends State<SimplePlayer> {
  double sliderValue = 0;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setAudioSource(AudioSource.uri(
      Uri.parse(widget.track.previewURL),
    ));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: _audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        return Row(
          children: [
            SizedBox(
              height: 27.5,
              width: 27.5,
              child: PlayerButton(
                audioPlayer: _audioPlayer,
                playerState: playerState,
              ),
            ),
            Expanded(
              child: StreamBuilder<Duration?>(
                stream: _audioPlayer.positionStream,
                builder: (context, snapshot) {
                  final currentDuration = snapshot.data;
                  return CustomSlider(
                    audioPlayer: _audioPlayer,
                    currentDuration: currentDuration,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
