import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get somethingWrong => 'Что-то пошло не так!';

  @override
  String get notFounded => 'Ничего не найдено';

  @override
  String get artists => 'Исполнители';

  @override
  String get search => 'Поиск';

  @override
  String get favorites => 'Коллекция';

  @override
  String get load => 'Загрузить ещё';

  @override
  String get confirmDelete => 'Вы уверены, что хотите удалить трек?';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get isInFavorites => 'В коллекции';

  @override
  String get addToFavorites => 'В коллекцию';

  @override
  String get language => 'Russian';
}
