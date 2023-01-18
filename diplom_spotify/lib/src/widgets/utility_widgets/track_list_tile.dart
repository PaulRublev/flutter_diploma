import 'package:diplom_spotify/src/widgets/player/bottom_sheet_player.dart';
import 'package:flutter/material.dart';
import 'package:diplom_spotify/src/utils/utils.dart' as global;
import 'package:module_model/module_model.dart';

class TrackListTile extends StatelessWidget {
  final Track track;
  final bool isFavorite;

  const TrackListTile(
      {super.key, required this.track, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: !isFavorite
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 15,
      ),
      child: Row(
        children: [
          Image.network(
            "${global.urlPrefix}${global.pathAlbumsImageserver}${track.albumId}"
            "${global.pathImage}${global.album70x70}${global.extension}",
            frameBuilder: (_, child, frame, __) {
              return frame == null
                  ? const SizedBox(
                      height: 65,
                      width: 65,
                    )
                  : child;
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 65,
                width: 65,
                color: Theme.of(context).colorScheme.primary,
                child: const Center(child: Text(global.noImageText)),
              );
            },
            fit: BoxFit.contain,
            width: 65,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  track.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 5),
                Text(
                  track.albumName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.overline,
                ),
              ],
            ),
          ),
          Material(
            color: !isFavorite
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).dialogBackgroundColor,
            child: IconButton(
              splashRadius: 25,
              padding: const EdgeInsets.all(18),
              icon: const Icon(Icons.play_circle_outline_rounded),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: const Color(0x00000000),
                  useRootNavigator: true,
                  builder: (context) => BottomSheetPlayer(
                    track: track,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
