import 'package:diplom_spotify/src/widgets/artists_page/artists_page.dart';
import 'package:diplom_spotify/src/widgets/collection_page/collection_page.dart';
import 'package:diplom_spotify/src/widgets/search_page/search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const String _textArtists = 'Исполнители';
  static const String _textSearch = 'Поиск';
  static const String _textCollection = 'Коллекция';

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) {
                  return const ArtistsPage(title: _textArtists);
                },
              );
            },
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) {
                  return const SearchPage(title: _textSearch);
                },
              );
            },
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) {
                  return const CollectionPage(title: _textCollection);
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_rounded),
            label: _textArtists,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: _textSearch,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            label: _textCollection,
          ),
        ],
        currentIndex: _tabController.index,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _tabController.index = index;
    });
  }
}
