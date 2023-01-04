import 'package:flutter/material.dart';

import '../theme/theme_data.dart';
import 'home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotifier',
      theme: darkThemeData,
      home: const HomePage(),
    );
  }
}
