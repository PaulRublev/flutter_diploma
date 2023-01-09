import 'package:diplom_spotify/src/widgets/artist_view/sliver_tracks_list.dart';
import 'package:flutter/material.dart';

class ArtistAboutPage extends StatelessWidget {
  const ArtistAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Ivan',
                style: Theme.of(context).textTheme.headline1,
              ),
              centerTitle: true,
              background: Image.network(
                'https://i.postimg.cc/1tf6qqQP/grozny.jpg',
                fit: BoxFit.fitWidth,
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
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          const SliverTracksList(),
        ],
      ),
    );
  }
}
