import 'package:diplom_spotify/widgets/artist_view/artist_about_page.dart';
import 'package:diplom_spotify/widgets/utility_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class ArtistGrid extends StatelessWidget {
  final Artist artist;

  const ArtistGrid({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ArtistAboutPage(artist: artist);
            },
          ),
        );
      },
      child: Hero(
        tag: artist.id,
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
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
                    style: Theme.of(context).textTheme.bodyText1,
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
