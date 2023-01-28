import 'package:diplom_spotify/widgets/artist_view/artists_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

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
      body: BlocBuilder<ArtistsCubit, ArtistsState>(
        buildWhen: (previous, current) =>
            current.status != ArtistsStatus.waiting,
        builder: (context, state) {
          final request = context.read<ArtistsCubit>().getArtists;
          return ArtistsGridView(state: state, request: request);
        },
      ),
    );
  }
}
