import 'package:diplom_spotify/widgets/collection_page/delete_dialog.dart';
import 'package:diplom_spotify/widgets/utility_widgets/track_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        actions: [
          IconButton(
            onPressed: context.read<TracklistCubit>().changeSortDirection,
            icon: const Icon(Icons.sort_rounded),
          ),
        ],
      ),
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: BlocBuilder<TracklistCubit, TracklistState>(
          builder: (context, state) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 15),
              itemCount: state.tracks.length,
              itemBuilder: (context, index) {
                final track = state.tracks[index];
                return Dismissible(
                  key: Key(track.id),
                  confirmDismiss: (direction) => _dialogBuilder(context),
                  onDismissed: (direction) {
                    final player = Provider.of<Player>(context, listen: false);
                    player.stopIfDeleted(track.previewURL);
                    context.read<TracklistCubit>().removeTrack(track);
                  },
                  child: TrackListTile(
                    track: track,
                    isFavorite: true,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<bool?> _dialogBuilder(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return const DeleteDialog();
      },
    );
  }
}
