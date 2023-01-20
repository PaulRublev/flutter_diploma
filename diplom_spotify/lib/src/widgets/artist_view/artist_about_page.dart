import 'package:diplom_spotify/src/widgets/artist_view/sliver_tracks_list.dart';
import 'package:flutter/material.dart';
import 'package:diplom_spotify/src/utils/utils.dart' as global;
import 'package:module_model/module_model.dart';

class ArtistAboutPage extends StatefulWidget {
  final Artist artist;

  const ArtistAboutPage({super.key, required this.artist});

  @override
  State<ArtistAboutPage> createState() => _ArtistAboutPageState();
}

class _ArtistAboutPageState extends State<ArtistAboutPage> {
  String artistAbout = '';

  @override
  void initState() {
    super.initState();
    for (var paragraph in widget.artist.blurbs) {
      artistAbout += '$paragraph\n\n';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.artist.name,
                style: Theme.of(context).textTheme.headline1,
              ),
              centerTitle: true,
              background: Image.network(
                "${global.urlPrefix}${global.pathArtistsImageserver}${widget.artist.id}"
                "${global.pathImage}${global.artist356x237}${global.extension}",
                fit: BoxFit.fitWidth,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return frame == null
                      ? Image.network(
                          "${global.urlPrefix}${global.pathArtistsImageserver}${widget.artist.id}"
                          "${global.pathImage}${global.artist150x100}${global.extension}",
                          fit: BoxFit.fitWidth,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Theme.of(context).colorScheme.primary,
                              child:
                                  const Center(child: Text(global.noImageText)),
                            );
                          },
                        )
                      : child;
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: const Center(child: Text(global.noImageText)),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                artistAbout,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          SliverTracksList(
            artistId: widget.artist.id,
          ),
        ],
      ),
    );
  }
}
