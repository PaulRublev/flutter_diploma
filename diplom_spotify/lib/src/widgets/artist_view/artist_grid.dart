import 'package:diplom_spotify/src/utils/artist.dart';
import 'package:diplom_spotify/src/widgets/artist_view/artist_about_page.dart';
import 'package:flutter/material.dart';
import 'package:diplom_spotify/src/utils/utils.dart' as global;

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
              child: Image.network(
                "${global.urlPrefix}${global.pathImageserver}${widget.artist.id}"
                "${global.pathImage}${global.artist150x100}${global.extension}",
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 45,
              child: Center(
                child: Text(
                  widget.artist.name ?? '',
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
