import 'package:get_it/get_it.dart';
import 'api/firebase_service.dart';
import 'implementation/my_firebase_service.dart';

class ServiceProvider {
  static final _getIt = GetIt.I;

  T get<T extends Object>() => _getIt.get<T>();

  static final instance = ServiceProvider();

  void initialize() {
    _getIt.registerLazySingleton<FirebaseService>(
      () => MyFirebaseService(),
    );
  }
}
