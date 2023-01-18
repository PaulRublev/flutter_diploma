import 'package:diplom_spotify/src/widgets/utility_widgets/track_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';

class CollectionPage extends StatefulWidget {
  final String title;

  const CollectionPage({super.key, required this.title});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with AutomaticKeepAliveClientMixin {
  bool isDescendent = true;

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
              setState(() {
                isDescendent = !isDescendent;
              });
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
                if (snapshot.hasError || !snapshot.hasData) {
                  return Container(
                    color: Colors.green,
                    height: 20,
                    width: 20,
                  );
                } else {
                  var tracks = snapshot.data ?? [];
                  if (!isDescendent) {
                    tracks = tracks.reversed.toList();
                  }
                  return ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      return TrackListTile(track: tracks[index]);
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
