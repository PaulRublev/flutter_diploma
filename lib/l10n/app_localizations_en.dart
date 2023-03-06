import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get somethingWrong => 'Something wrong!';

  @override
  String get notFounded => 'Not founded';

  @override
  String get artists => 'Artists';

  @override
  String get search => 'Search';

  @override
  String get favorites => 'Favorites';

  @override
  String get load => 'Load more';

  @override
  String get confirmDelete => 'Are you sure you want to delete this track?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get isInFavorites => 'In favorites';

  @override
  String get addToFavorites => 'To favorites';

  @override
  String get language => 'English';
}
