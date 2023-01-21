import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class CachedImage extends StatelessWidget {
  final Track track;

  const CachedImage({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
      ),
      child: CachedNetworkImage(
        imageUrl: "https://api.napster.com/imageserver/v2/albums/"
            "${track.albumId}/images/170x170.jpg",
        fit: BoxFit.fill,
        placeholder: (context, url) => CachedNetworkImage(
          imageUrl: "https://api.napster.com/imageserver/v2/albums/"
              "${track.albumId}/images/70x70.jpg",
          fit: BoxFit.fill,
          placeholder: (context, url) => Container(),
          errorWidget: (context, _, __) {
            return const Center(child: Text('NO IMAGE'));
          },
        ),
        errorWidget: (context, _, __) {
          return const Center(child: Text('NO IMAGE'));
        },
      ),
    );
  }
}
