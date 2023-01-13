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
      ),
      body: Material(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Consumer<Collection>(
            builder: (context, value, child) {
              var tracks = value.tracks.values.toList();
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
