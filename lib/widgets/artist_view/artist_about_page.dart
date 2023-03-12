import 'package:diplom_spotify/widgets/utility_widgets/cached_image.dart';
import 'package:diplom_spotify/widgets/artist_view/sliver_tracks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';

class ArtistAboutPage extends StatelessWidget {
  final String id;

  const ArtistAboutPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final artist = getArtist(context, id);

    return Hero(
      tag: artist.id,
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  artist.name,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                centerTitle: true,
                background: CachedImage.artist356x237(
                  artistId: artist.id,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Builder(builder: (context) {
                  String artistAbout = '';
                  for (var paragraph in artist.blurbs) {
                    artistAbout += '$paragraph\n\n';
                  }

                  return Text(
                    artistAbout,
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                }),
              ),
            ),
            SliverTracksList(
              artistId: artist.id,
            ),
          ],
        ),
      ),
    );
  }

  Artist getArtist(BuildContext context, String id) {
    return BlocProvider.of<ArtistsCubit>(context)
        .state
        .artists
        .singleWhere((element) => element.id == id);
  }
}
