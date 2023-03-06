import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class CachedImage extends StatelessWidget {
  late final String imageUrl;
  late final Widget placeholder;

  CachedImage.album70x70({super.key, required String albumId}) {
    imageUrl = NapsterApi.album70x70ImageUrl(albumId);
    placeholder = Container();
  }

  CachedImage.album170x170({super.key, required String albumId}) {
    imageUrl = NapsterApi.album170x170ImageUrl(albumId);
    placeholder = CachedImage.album70x70(albumId: albumId);
  }

  CachedImage.artist150x100({super.key, required String artistId}) {
    imageUrl = NapsterApi.artist150x100ImageUrl(artistId);
    placeholder = Container();
  }

  CachedImage.artist356x237({super.key, required String artistId}) {
    imageUrl = NapsterApi.artist356x237ImageUrl(artistId);
    placeholder = CachedImage.artist150x100(artistId: artistId);
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fitWidth,
      placeholder: (context, _) => placeholder,
      errorWidget: (context, _, __) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: const Center(child: Icon(Icons.broken_image_outlined)),
        );
      },
    );
  }
}
