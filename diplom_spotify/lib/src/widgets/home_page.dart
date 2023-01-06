import 'package:diplom_spotify/src/widgets/artists_page.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
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
        controller: _tabController,
        children: [
          const ArtistsPage(title: _textArtists),
          Container(child: const Text('2')),
          Container(child: const Text('3')),
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
}
