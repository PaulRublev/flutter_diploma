import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom_spotify/utils/favorite_tracks_notifier.dart';
import 'package:diplom_spotify/widgets/player/simple_player.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:provider/provider.dart';

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
              Container(
                clipBehavior: Clip.antiAlias,
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: CachedNetworkImage(
                  imageUrl: "https://api.napster.com/imageserver/v2/albums/"
                      "${track.albumId}/images/170x170.jpg",
                  fit: BoxFit.fill,
                  placeholder: (context, url) => CachedNetworkImage(
                    imageUrl: "https://api.napster.com/imageserver/v2/albums/"
                        "${track.albumId}/images/70x70.jpg",
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, _, __) {
                      return const Center(child: Text('NO IMAGE'));
                    },
                  ),
                  errorWidget: (context, _, __) {
                    return const Center(child: Text('NO IMAGE'));
                  },
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
                        height: 35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.albumName,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.overline,
                            ),
                            const Spacer(),
                            Text(
                              track.name,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Consumer<FavoriteTracksNotifier>(
                        builder: (context, favoriteTracks, child) {
                          if (!favoriteTracks.isInitialize) return Container();
                          final isInCollection =
                              favoriteTracks.tracks.contains(track);
                          return isInCollection
                              ? Container(
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'В коллекции',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 30,
                                  width: 120,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      BlocFactory
                                          .instance.mainBloc.firebaseService
                                          .addTrack(track.id);
                                    },
                                    child: Center(
                                      child: Text(
                                        'В коллекцию',
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