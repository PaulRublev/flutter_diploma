import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom_spotify/widgets/artist_view/artist_about_page.dart';
import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

class ArtistGrid extends StatefulWidget {
  final Artist artist;

  const ArtistGrid({super.key, required this.artist});

  @override
  State<ArtistGrid> createState() => _ArtistGridState();
}

class _ArtistGridState extends State<ArtistGrid> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ArtistAboutPage(artist: widget.artist);
            },
          ),
        );
      },
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
              child: CachedNetworkImage(
                imageUrl: "https://api.napster.com/imageserver/v2/artists/"
                    "${widget.artist.id}/images/150x100.jpg",
                fit: BoxFit.fitWidth,
                errorWidget: (context, _, __) {
                  return Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: const Center(child: Text('NO IMAGE')),
                  );
                },
              ),
            ),
            SizedBox(
              height: 45,
              child: Center(
                child: Text(
                  widget.artist.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
