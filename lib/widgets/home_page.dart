import 'package:diplom_spotify/l10n/app_localizations.dart';
import 'package:diplom_spotify/widgets/artists_page/artists_page.dart';
import 'package:diplom_spotify/widgets/collection_page/collection_page.dart';
import 'package:diplom_spotify/widgets/search_page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ValueNotifier<int> _tabNotifier;

  late String _textArtists;
  late String _textSearch;
  late String _textCollection;

  @override
  void initState() {
    BlocProvider.of<TracklistCubit>(context, listen: false).getTracklist();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 1),
    );
    _tabNotifier = ValueNotifier(_tabController.index);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textArtists = AppLocalizations.of(context)!.artists;
    _textSearch = AppLocalizations.of(context)!.search;
    _textCollection = AppLocalizations.of(context)!.favorites;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          HeroControllerScope(
            controller: MaterialApp.createMaterialHeroController(),
            child: Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider<ArtistsCubit>(
                      create: (_) => ArtistsCubit(),
                      child: ArtistsPage(title: _textArtists),
                    );
                  },
                );
              },
            ),
          ),
          HeroControllerScope(
            controller: MaterialApp.createMaterialHeroController(),
            child: Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (_) => ArtistsCubit(),
                      child: SearchPage(title: _textSearch),
                    );
                  },
                );
              },
            ),
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) {
                  return CollectionPage(title: _textCollection);
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _tabNotifier,
        builder: (context, index, _) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.library_music_rounded),
                label: _textArtists,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search_rounded),
                label: _textSearch,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite_border_rounded),
                label: _textCollection,
              ),
            ],
            currentIndex: index,
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    _tabController.index = index;
    _tabNotifier.value = index;
  }
}
