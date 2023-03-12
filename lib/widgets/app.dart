import 'package:diplom_spotify/l10n/all_locales.dart';
import 'package:diplom_spotify/l10n/app_localizations.dart';
import 'package:diplom_spotify/theme/theme_data.dart';
import 'package:diplom_spotify/widgets/artist_view/artist_about_page.dart';
import 'package:diplom_spotify/widgets/artists_page/artists_page.dart';
import 'package:diplom_spotify/widgets/collection_page/collection_page.dart';
import 'package:diplom_spotify/widgets/home_page.dart';
import 'package:diplom_spotify/widgets/search_page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:module_business/module_business.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  App({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/artists',
    routes: [
      ShellRoute(
        builder: (context, state, child) => HomePage(child: child),
        routes: [
          GoRoute(
            path: '/artists',
            builder: (context, state) => BlocProvider<ArtistsCubit>(
              create: (_) => ArtistsCubit(),
              child: ArtistsPage(title: state.queryParams['title'] ?? ''),
            ),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => BlocProvider<ArtistsCubit>(
              create: (_) => ArtistsCubit(),
              child: SearchPage(title: state.queryParams['title'] ?? ''),
            ),
          ),
          GoRoute(
            path: '/favorite',
            builder: (context, state) =>
                CollectionPage(title: state.queryParams['title'] ?? ''),
          ),
          GoRoute(
            path: '/about:id',
            builder: (context, state) =>
                ArtistAboutPage(id: state.params['id'] ?? ''),
          ),
        ],
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Provider<Player>(
      lazy: false,
      create: (context) => Player(),
      dispose: (context, value) => value.dispose(),
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(lazy: false, create: (_) => TracklistCubit()),
            BlocProvider(create: (_) => TopTracksCubit()),
          ],
          child: MaterialApp.router(
            routerConfig: _router,
            supportedLocales: AllLocales.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Spotifier',
            theme: themeData,
          ),
        );
      },
    );
  }
}
