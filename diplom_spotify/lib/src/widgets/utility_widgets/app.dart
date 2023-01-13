import 'package:diplom_spotify/src/utils/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_data.dart';
import '../home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Collection>(
      create: (_) => Collection(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spotifier',
        theme: darkThemeData,
        home: const HomePage(),
      ),
    );
  }
}
