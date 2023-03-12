import 'package:diplom_spotify/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:module_business/module_business.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.child});

  final Widget child;

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
      body: widget.child,
      // TabBarView(
      //   physics: const NeverScrollableScrollPhysics(),
      //   controller: _tabController,
      //   children: [
      //     HeroControllerScope(
      //       controller: MaterialApp.createMaterialHeroController(),
      //       child: Navigator(
      //         onGenerateRoute: (settings) {
      //           return MaterialPageRoute(
      //             builder: (context) {
      //               return BlocProvider<ArtistsCubit>(
      //                 create: (_) => ArtistsCubit(),
      //                 child: ArtistsPage(title: _textArtists),
      //               );
      //             },
      //           );
      //         },
      //       ),
      //     ),
      //     HeroControllerScope(
      //       controller: MaterialApp.createMaterialHeroController(),
      //       child: Navigator(
      //         onGenerateRoute: (settings) {
      //           return MaterialPageRoute(
      //             builder: (context) {
      //               return BlocProvider(
      //                 create: (_) => ArtistsCubit(),
      //                 child: SearchPage(title: _textSearch),
      //               );
      //             },
      //           );
      //         },
      //       ),
      //     ),
      //     Navigator(
      //       onGenerateRoute: (settings) {
      //         return MaterialPageRoute(
      //           builder: (context) {
      //             return CollectionPage(title: _textCollection);
      //           },
      //         );
      //       },
      //     ),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _calculateIndex(context),
        onTap: (value) => _onItemTapped(value, context),
      ),
    );
  }

  static int _calculateIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/artists')) {
      return 0;
    }
    if (location.startsWith('/search')) {
      return 1;
    }
    if (location.startsWith('/favorite')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(
          Uri(
            path: '/artists',
            queryParameters: {'title': _textArtists},
          ).toString(),
        );
        break;
      case 1:
        GoRouter.of(context).go(
          Uri(
            path: '/search',
            queryParameters: {'title': _textSearch},
          ).toString(),
        );
        break;
      case 2:
        GoRouter.of(context).go(
          Uri(
            path: '/favorite',
            queryParameters: {'title': _textCollection},
          ).toString(),
        );
        break;
    }
  }
}
