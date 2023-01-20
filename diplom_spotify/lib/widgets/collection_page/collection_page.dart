import 'package:diplom_spotify/utils/favorite_tracks_notifier.dart';
import 'package:diplom_spotify/widgets/utility_widgets/track_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
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
                  padding: const EdgeInsets.only(top: 15),
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    final track = tracks[index];
                    return Dismissible(
                      key: Key(track.id),
                      confirmDismiss: (direction) => _dialogBuilder(context),
                      onDismissed: (direction) {
                        BlocFactory.instance.mainBloc.firebaseService
                            .removeTrack(track.id);
                      },
                      child: TrackListTile(
                        track: track,
                        isFavorite: true,
                      ),
                    );
                  },
                );
              },
            );
          },
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

  Future<bool?> _dialogBuilder(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(builder: (context, constraints) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 45, vertical: 200),
            title: Text(
              'Вы уверены, что хотите удалить трек?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            actions: <Widget>[
              OutlinedButton(
                child: SizedBox(
                  height: 30,
                  width: constraints.maxWidth / 5,
                  child: Center(
                    child: Text(
                      'Да',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              OutlinedButton(
                child: SizedBox(
                  height: 30,
                  width: constraints.maxWidth / 5,
                  child: Center(
                    child: Text(
                      'Нет',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        });
      },
    );
  }
}
