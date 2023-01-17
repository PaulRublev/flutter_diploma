import 'package:diplom_spotify/src/theme/theme_data.dart';
import 'package:diplom_spotify/src/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotifier',
      theme: darkThemeData,
      home: const HomePage(),
    );
  }
}
