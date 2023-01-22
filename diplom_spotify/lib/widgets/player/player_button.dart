import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButton extends StatelessWidget {
  final PlayerState? playerState;
  final AudioPlayer? audioPlayer;

  const PlayerButton({super.key, this.playerState, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    final processingState = playerState?.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: const CircularProgressIndicator(strokeWidth: 3),
        ),
      );
    } else if (audioPlayer == null || processingState == null) {
      return Container();
    } else if (audioPlayer!.playing != true) {
      return IconButton(
        icon: const Icon(Icons.play_circle_outline_rounded),
        visualDensity: VisualDensity.compact,
        splashRadius: 1,
        padding: const EdgeInsets.all(1),
        onPressed: audioPlayer!.play,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        icon: const Icon(Icons.pause_circle_outline_rounded),
        visualDensity: VisualDensity.compact,
        splashRadius: 1,
        padding: const EdgeInsets.all(1),
        onPressed: audioPlayer!.pause,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.replay_rounded),
        visualDensity: VisualDensity.compact,
        splashRadius: 1,
        padding: const EdgeInsets.all(1),
        onPressed: () => audioPlayer!.seek(
          Duration.zero,
          index: audioPlayer!.effectiveIndices?.first,
        ),
      );
    }
  }
}
