import 'package:flutter/material.dart';

import 'artists_grid_view.dart';

class ArtistsPage extends StatelessWidget {
  final String title;

  const ArtistsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 83,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: const ArtistsGridView(),
    );
  }
}
