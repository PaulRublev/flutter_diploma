import 'package:diplom_spotify/widgets/utility_widgets/styled_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:provider/provider.dart';

class PlayerButton extends StatelessWidget {
  final String trackUri;

  const PlayerButton({super.key, required this.trackUri});

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<Player>(context, listen: true);

    return StreamBuilder(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final processingState = snapshot.data?.processingState;
        if (trackUri != player.trackUri) {
          return StyledIconButton(
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
          return StyledIconButton(
            Icons.play_circle_outline_rounded,
            onPressed: () {
              player.audioPlayer!.play();
            },
          );
        } else if (processingState != ProcessingState.completed) {
          return StyledIconButton(
            Icons.pause_circle_outline_rounded,
            onPressed: () => player.audioPlayer!.pause(),
          );
        } else {
          return StyledIconButton(
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
