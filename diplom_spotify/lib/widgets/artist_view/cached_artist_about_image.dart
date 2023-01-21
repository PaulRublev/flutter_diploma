import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom_spotify/widgets/artist_view/cached_artist_grid_image.dart';
import 'package:flutter/material.dart';

class CachedArtistAboutImage extends StatelessWidget {
  final String artistId;

  const CachedArtistAboutImage({super.key, required this.artistId});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "https://api.napster.com/imageserver/v2/artists/"
          "$artistId/images/356x237.jpg",
      fit: BoxFit.fitWidth,
      placeholder: (context, _) {
        return CachedArtistGridImage(artistId: artistId);
      },
      errorWidget: (context, _, __) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: const Center(child: Text('NO IMAGE')),
        );
      },
    );
  }
}
