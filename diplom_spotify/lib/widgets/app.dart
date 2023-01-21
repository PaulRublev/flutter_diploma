import 'dart:async';

import 'package:diplom_spotify/theme/theme_data.dart';
import 'package:diplom_spotify/utils/favorite_tracks_notifier.dart';
import 'package:diplom_spotify/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final networkService = BlocFactory.instance.mainBloc.networkService;
    final firebaseService = BlocFactory.instance.mainBloc.firebaseService;
    final Stream<List<Track>> stream = networkService.streamTracks(
      firebaseService.streamTrackIds(),
    );

    return ChangeNotifierProvider<FavoriteTracksNotifier>(
      create: (context) => FavoriteTracksNotifier(stream),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Spotifier',
          theme: darkThemeData,
          home: const HomePage(),
        );
      },
    );
  }
}
