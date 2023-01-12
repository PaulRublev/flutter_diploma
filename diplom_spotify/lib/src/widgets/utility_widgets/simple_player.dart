import 'package:diplom_spotify/src/utils/track.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
      Uri.parse(widget.track.previewURL ?? ''),
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
                child: _playerButton(playerState),
              ),
              Expanded(
                child: StreamBuilder<Duration?>(
                  stream: _audioPlayer.positionStream,
                  builder: (context, snapshot) {
                    final currentDuration = snapshot.data;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Slider(
                            divisions: 180,
                            value: (currentDuration?.inMilliseconds ?? 0)
                                .toDouble(),
                            max: (_audioPlayer.duration?.inMilliseconds ?? 0)
                                    .toDouble() +
                                10,
                            onChanged: (value) {
                              _audioPlayer
                                  .seek(Duration(milliseconds: value.toInt()));
                            },
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              currentDuration?.toString().substring(0, 7) ??
                                  '-',
                              style: Theme.of(context).textTheme.overline,
                            ),
                            const Spacer(flex: 10),
                            Text(
                              _audioPlayer.duration
                                      ?.toString()
                                      .substring(0, 7) ??
                                  '-',
                              style: Theme.of(context).textTheme.overline,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget _playerButton(PlayerState? playerState) {
    final processingState = playerState?.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: const CircularProgressIndicator(strokeWidth: 3),
        ),
      );
    } else if (_audioPlayer.playing != true) {
      return IconButton(
        icon: const Icon(Icons.play_circle_outline_rounded),
        visualDensity: VisualDensity.compact,
        splashRadius: 1,
        padding: const EdgeInsets.all(1),
        onPressed: _audioPlayer.play,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        icon: const Icon(Icons.pause_circle_outline_rounded),
        visualDensity: VisualDensity.compact,
        splashRadius: 1,
        padding: const EdgeInsets.all(1),
        onPressed: _audioPlayer.pause,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.replay_rounded),
        visualDensity: VisualDensity.compact,
        splashRadius: 1,
        padding: const EdgeInsets.all(1),
        onPressed: () => _audioPlayer.seek(
          Duration.zero,
          index: _audioPlayer.effectiveIndices?.first,
        ),
      );
    }
  }
}
