import 'package:diplom_spotify/src/utils/collection.dart';
import 'package:diplom_spotify/src/utils/track.dart';
import 'package:diplom_spotify/src/widgets/player/simple_player.dart';
import 'package:flutter/material.dart';
import 'package:diplom_spotify/src/utils/utils.dart' as global;
import 'package:provider/provider.dart';

class BottomSheetPlayer extends StatelessWidget {
  static const collectionButtonText = 'В коллекцию';

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
              Container(
                clipBehavior: Clip.antiAlias,
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Image.network(
                  "${global.urlPrefix}${global.pathAlbumsImageserver}${track.albumId}"
                  "${global.pathImage}${global.album170x170}${global.extension}",
                  frameBuilder: (_, child, frame, __) {
                    return frame == null ? const SizedBox() : child;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        global.noImageText,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  },
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.albumName,
                              style: Theme.of(context).textTheme.overline,
                            ),
                            const Spacer(),
                            Text(
                              track.name,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Consumer<Collection>(
                        builder: (context, value, _) {
                          final isInCollection =
                              value.tracks.containsKey(track.id);
                          return isInCollection
                              ? const SizedBox(height: 48)
                              : ElevatedButton(
                                  onPressed: () {
                                    track.date =
                                        DateTime.now().millisecondsSinceEpoch;
                                    value.add(track);
                                  },
                                  child: SizedBox(
                                    height: 30,
                                    width: 120,
                                    child: Center(
                                      child: Text(
                                        collectionButtonText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
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
