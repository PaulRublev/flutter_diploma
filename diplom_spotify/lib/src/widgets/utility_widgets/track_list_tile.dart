import 'package:diplom_spotify/src/utils/track.dart';
import 'package:diplom_spotify/src/widgets/player/bottom_sheet_player.dart';
import 'package:flutter/material.dart';
import 'package:diplom_spotify/src/utils/utils.dart' as global;

class TrackListTile extends StatelessWidget {
  final Track track;

  const TrackListTile({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
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
                child: const Center(child: Text('NO IMAGE')),
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
                  track.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 5),
                Text(
                  track.albumName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.overline,
                ),
              ],
            ),
          ),
          Material(
            child: IconButton(
              splashRadius: 25,
              padding: const EdgeInsets.all(18),
              icon: const Icon(Icons.play_circle_outline_rounded),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: const Color(0x00000000),
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
