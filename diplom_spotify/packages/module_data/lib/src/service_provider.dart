import 'package:get_it/get_it.dart';
import 'package:module_data/module_data.dart';
import 'package:module_data/src/implementation/dummy_firebase_service.dart';
import 'package:module_data/src/implementation/my_firebase_service.dart';
import 'package:module_data/src/implementation/network_service_implementation.dart';

class ServiceProvider {
  static final _getIt = GetIt.I;

  T get<T extends Object>() => _getIt.get<T>();

  static final instance = ServiceProvider();

  void initialize() {
    _getIt.registerLazySingleton<FirebaseService>(
      // () => MyFirebaseService(), // todo FIREBASE SERVICE SWITCHER
      () => DummyFirebaseService(),
    );
    _getIt.registerLazySingleton<NetworkService>(
      () => NetworkServiceImplementation(),
    );
  }
}
