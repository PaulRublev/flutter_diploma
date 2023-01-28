import 'dart:async';

import 'package:diplom_spotify/widgets/artist_view/artists_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

class SearchPage extends StatefulWidget {
  final String title;

  const SearchPage({super.key, required this.title});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController editingController = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          constraints: const BoxConstraints(maxHeight: 36),
          height: 83,
          child: Center(
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.background,
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline2,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
              style: Theme.of(context).textTheme.headline2,
              autocorrect: false,
              onChanged: (value) => _onSearchChanged(value, context),
              onEditingComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              cursorColor: Theme.of(context).colorScheme.onBackground,
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchArtistsCubit, ArtistsState>(
        buildWhen: (previous, current) =>
            current.status != ArtistsStatus.waiting,
        builder: (context, state) {
          return editingController.value.text != ''
              ? ArtistsGridView(
                  key: Key(editingController.value.text),
                  search: editingController.value.text,
                  state: state,
                  request: context.read<SearchArtistsCubit>().getArtists,
                )
              : Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query, BuildContext context) {
    if (_debounce?.isActive == true) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchArtistsCubit>().setLoadingState();
    });
  }
}
