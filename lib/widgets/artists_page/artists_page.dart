import 'package:diplom_spotify/widgets/artist_view/artists_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

class ArtistsPage extends StatefulWidget {
  final String title;

  const ArtistsPage({super.key, required this.title});

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ArtistsCubit>().getInitialArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: BlocBuilder<ArtistsCubit, ArtistsState>(
        builder: (context, state) {
          return ArtistsGridView(state: state);
        },
      ),
    );
  }
}
