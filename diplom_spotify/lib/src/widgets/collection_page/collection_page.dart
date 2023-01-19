import 'package:diplom_spotify/src/utils/favorite_tracks_notifier.dart';
import 'package:diplom_spotify/src/widgets/utility_widgets/track_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionPage extends StatefulWidget {
  final String title;

  const CollectionPage({super.key, required this.title});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with AutomaticKeepAliveClientMixin {
  ValueNotifier<bool> isDescendentNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 83,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          IconButton(
            onPressed: () {
              isDescendentNotifier.value = !isDescendentNotifier.value;
            },
            icon: const Icon(Icons.sort_rounded),
          ),
        ],
      ),
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Consumer<FavoriteTracksNotifier>(
            builder: (context, favoriteTracks, child) {
              return ValueListenableBuilder(
                valueListenable: isDescendentNotifier,
                builder: (context, value, child) {
                  var tracks = favoriteTracks.tracks;
                  if (!value) {
                    tracks = tracks.reversed.toList();
                  }
                  return ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      return TrackListTile(
                        track: tracks[index],
                        isFavorite: true,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    isDescendentNotifier.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
