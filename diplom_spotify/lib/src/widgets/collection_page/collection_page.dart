import 'package:diplom_spotify/src/utils/collection.dart';
import 'package:diplom_spotify/src/widgets/utility_widgets/track_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionPage extends StatelessWidget {
  final String title;

  const CollectionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 83,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<Collection>(context, listen: false)
                  .changeSortDirection();
            },
            icon: const Icon(Icons.sort_rounded),
          ),
        ],
      ),
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Consumer<Collection>(
            builder: (context, value, child) {
              var tracks = value.tracks.values.toList();
              if (value.isAscending) {
                tracks.sort((a, b) => a.date.compareTo(b.date));
              } else {
                tracks.sort((a, b) => b.date.compareTo(a.date));
              }
              return ListView.builder(
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  return TrackListTile(track: tracks[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
