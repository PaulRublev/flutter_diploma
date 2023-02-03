import 'package:diplom_spotify/widgets/player/components/bottom_sheet_player_control.dart';
import 'package:diplom_spotify/widgets/player/player_button.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:provider/provider.dart';

class SimplePlayer extends StatefulWidget {
  final NapsterTrack track;

  const SimplePlayer({super.key, required this.track});

  @override
  State<SimplePlayer> createState() => _SimplePlayerState();
}

class _SimplePlayerState extends State<SimplePlayer> {
  late Player player;

  @override
  void initState() {
    super.initState();
    player = Provider.of<Player>(context, listen: false);
    if (widget.track.previewURL != player.trackUri) {
      player.setTrackUri(widget.track.previewURL);
      player.audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 27.5,
          width: 27.5,
          child: PlayerButton(trackUri: widget.track.previewURL),
        ),
        Expanded(
          child: StreamBuilder<Duration?>(
            stream: player.audioPlayer.positionStream,
            builder: (context, snapshot) {
              final currentDuration = snapshot.data;
              return BottomSheetPlayerControl(
                audioPlayer: player.audioPlayer,
                currentDuration: currentDuration,
              );
            },
          ),
        ),
      ],
    );
  }
}
