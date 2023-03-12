import 'package:diplom_spotify/widgets/utility_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:module_model/module_model.dart';

class ArtistGrid extends StatelessWidget {
  final Artist artist;

  const ArtistGrid({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        context.go('/about:${artist.id}');
      },
      child: Hero(
        tag: artist.id,
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CachedImage.artist150x100(
                  artistId: artist.id,
                ),
              ),
              SizedBox(
                height: 45,
                child: Center(
                  child: Text(
                    artist.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
