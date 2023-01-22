import 'package:diplom_spotify/widgets/utility_widgets/custom_cached_image.dart';
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
      child: CustomCachedImage.album170x170(albumId: track.albumId),
    );
  }
}
