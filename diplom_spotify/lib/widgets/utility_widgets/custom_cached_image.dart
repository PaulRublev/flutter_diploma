import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  late final String imageSize;
  late final String pathPart;
  late final Widget placeholder;

  CustomCachedImage.album70x70({super.key, required String albumId}) {
    imageSize = '70x70';
    pathPart = '/albums/$albumId';
    placeholder = Container();
  }

  CustomCachedImage.album170x170({super.key, required String albumId}) {
    imageSize = '170x170';
    pathPart = '/albums/$albumId';
    placeholder = CustomCachedImage.album70x70(albumId: albumId);
  }

  CustomCachedImage.artist150x100({super.key, required String artistId}) {
    imageSize = '150x100';
    pathPart = '/artists/$artistId';
    placeholder = Container();
  }

  CustomCachedImage.artist356x237({super.key, required String artistId}) {
    imageSize = '356x237';
    pathPart = '/artists/$artistId';
    placeholder = CustomCachedImage.artist150x100(artistId: artistId);
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "https://api.napster.com/imageserver/v2"
          "$pathPart/images/$imageSize.jpg",
      fit: BoxFit.fitWidth,
      placeholder: (context, _) => placeholder,
      errorWidget: (context, _, __) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: const Center(child: Text('NO IMAGE')),
        );
      },
    );
  }
}
