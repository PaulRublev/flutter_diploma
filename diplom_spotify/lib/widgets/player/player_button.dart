import 'package:diplom_spotify/utils/player.dart';
import 'package:diplom_spotify/widgets/utility_widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class PlayerButton extends StatelessWidget {
  final String trackUri;

  const PlayerButton({super.key, required this.trackUri});

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<Player>(context, listen: true);
    player.initialize();

    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final processingState = snapshot.data?.processingState;
        if (trackUri != player.trackUri) {
          return CustomIconButton(
            Icons.play_circle_outline_rounded,
            onPressed: () {
              player.setTrackUri(trackUri);
              player.audioPlayer!.play();
            },
          );
        }
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: const CircularProgressIndicator(strokeWidth: 3),
            ),
          );
        } else if (player.audioPlayer == null || processingState == null) {
          return Container();
        } else if (!player.audioPlayer!.playing) {
          return CustomIconButton(
            Icons.play_circle_outline_rounded,
            onPressed: () {
              player.audioPlayer!.play();
            },
          );
        } else if (processingState != ProcessingState.completed) {
          return CustomIconButton(
            Icons.pause_circle_outline_rounded,
            onPressed: () => player.audioPlayer!.pause(),
          );
        } else {
          return CustomIconButton(
            Icons.replay_rounded,
            onPressed: () => player.audioPlayer!.seek(
              Duration.zero,
              index: player.audioPlayer!.effectiveIndices?.first,
            ),
          );
        }
      },
    );
  }
}
