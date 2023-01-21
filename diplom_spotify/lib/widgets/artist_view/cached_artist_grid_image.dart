import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedArtistGridImage extends StatelessWidget {
  final String artistId;

  const CachedArtistGridImage({super.key, required this.artistId});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "https://api.napster.com/imageserver/v2/artists/"
          "$artistId/images/150x100.jpg",
      fit: BoxFit.fitWidth,
      errorWidget: (context, _, __) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: const Center(child: Text('NO IMAGE')),
        );
      },
    );
  }
}
