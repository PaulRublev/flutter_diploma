import 'package:diplom_spotify/src/widgets/sliver_tracks_list.dart';
import 'package:flutter/material.dart';

class ArtistAboutPage extends StatelessWidget {
  const ArtistAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Ivan'),
              centerTitle: true,
              background: Image.network(
                'https://i.postimg.cc/1tf6qqQP/grozny.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                "Voluptate tempor sit reprehenderit "
                "Reprehenderit Lorem aliqua laborum ad.Eu ullamco minim "
                "occaecat sit magna id esse aliqua.",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  height: 1.26,
                ),
              ),
            ),
          ),
          const SliverTracksList(),
        ],
      ),
    );
  }
}
