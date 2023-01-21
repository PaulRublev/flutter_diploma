import 'package:diplom_spotify/widgets/player/cached_image.dart';
import 'package:diplom_spotify/widgets/player/favorite_button.dart';
import 'package:diplom_spotify/widgets/player/simple_player.dart';
import 'package:diplom_spotify/widgets/player/track_info.dart';
import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class BottomSheetPlayer extends StatelessWidget {
  final Track track;

  const BottomSheetPlayer({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(25),
      height: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedImage(track: track),
              const SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TrackInfo(track: track),
                      const Spacer(),
                      FavoriteButton(track: track),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SimplePlayer(track: track),
        ],
      ),
    );
  }
}
