import 'package:flutter/material.dart';

import 'artists_grid_view.dart';

class ArtistsPage extends StatelessWidget {
  final String title;

  const ArtistsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ArtistsGridView(
        storageKeyName: title,
      ),
    );
  }
}
