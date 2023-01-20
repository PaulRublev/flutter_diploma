import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom_spotify/src/widgets/artist_view/sliver_tracks_list.dart';
import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class ArtistAboutPage extends StatefulWidget {
  final Artist artist;

  const ArtistAboutPage({super.key, required this.artist});

  @override
  State<ArtistAboutPage> createState() => _ArtistAboutPageState();
}

class _ArtistAboutPageState extends State<ArtistAboutPage> {
  static const artist150x100 = '150x100';
  static const artist356x237 = '356x237';
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
              background: CachedNetworkImage(
                imageUrl: "https://api.napster.com/imageserver/v2/artists/"
                    "${widget.artist.id}/images/$artist356x237.jpg",
                fit: BoxFit.fitWidth,
                placeholder: (context, _) {
                  return CachedNetworkImage(
                    imageUrl: "https://api.napster.com/imageserver/v2/artists/"
                        "${widget.artist.id}/images/$artist150x100.jpg",
                    fit: BoxFit.fitWidth,
                    errorWidget: (context, _, __) {
                      return Container(
                        color: Theme.of(context).colorScheme.primary,
                        child: const Center(child: Text('NO IMAGE')),
                      );
                    },
                  );
                },
                errorWidget: (context, _, __) {
                  return Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: const Center(child: Text('NO IMAGE')),
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
