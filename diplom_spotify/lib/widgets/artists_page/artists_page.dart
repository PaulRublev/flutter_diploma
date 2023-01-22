import 'package:diplom_spotify/widgets/artist_view/artists_grid_view.dart';
import 'package:flutter/material.dart';

class ArtistsPage extends StatelessWidget {
  final String title;

  const ArtistsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: const ArtistsGridView(),
    );
  }
}
