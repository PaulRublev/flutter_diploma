import 'package:diplom_spotify/src/widgets/utility_widgets/track_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';

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
              // todo change sort direction
            },
            icon: const Icon(Icons.sort_rounded),
          ),
        ],
      ),
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: StreamBuilder<List<Track>>(
            stream:
                BlocFactory.instance.mainBloc.firebaseService.streamTracks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return Container();
              } else {
                if (snapshot.hasError) {
                  return Container();
                }
                return !snapshot.hasData
                    ? Container()
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return TrackListTile(track: snapshot.data![index]);
                        },
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}
