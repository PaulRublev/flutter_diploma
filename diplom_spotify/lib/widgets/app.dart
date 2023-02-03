import 'package:diplom_spotify/l10n/all_locales.dart';
import 'package:diplom_spotify/l10n/app_localizations.dart';
import 'package:diplom_spotify/theme/theme_data.dart';
import 'package:diplom_spotify/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

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
        return MaterialApp(
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
          home: MultiBlocProvider(
            providers: [
              BlocProvider(lazy: false, create: (_) => TracklistCubit()),
              BlocProvider(create: (_) => TopTracksCubit()),
            ],
            child: const HomePage(),
          ),
        );
      },
    );
  }
}
