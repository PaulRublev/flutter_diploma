import 'dart:async';

import 'package:diplom_spotify/theme/theme_data.dart';
import 'package:diplom_spotify/utils/favorite_tracks_notifier.dart';
import 'package:diplom_spotify/utils/player.dart';
import 'package:diplom_spotify/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final Stream<List<NapsterTrack>> stream = _streamFromStream(
      networkService.streamFutureTracks(
        firebaseService.streamDatabaseTracks(),
      ),
    );

    return ChangeNotifierProvider<FavoriteTracksNotifier>(
      create: (context) => FavoriteTracksNotifier(stream),
      builder: (context, _) {
        return Provider<Player>(
          create: (context) => Player(),
          dispose: (context, value) => value.dispose(),
          builder: (context, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Spotifier',
              theme: themeData,
              home: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => ArtistsCubit()),
                  BlocProvider(create: (_) => ArtistsCubit()),
                  BlocProvider(create: (_) => TopTracksCubit()),
                ],
                child: const HomePage(),
              ),
            );
          },
        );
      },
    );
  }

  Stream<T> _streamFromStream<T>(Stream<Future<T>> futures) async* {
    await for (final chunk in futures) {
      yield await chunk;
    }
  }
}
