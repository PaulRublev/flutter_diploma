// ignore_for_file: unused_import

import 'package:get_it/get_it.dart';
import 'package:module_data/module_data.dart';
import 'package:module_data/src/implementation/dummy_firebase_service.dart';
import 'package:module_data/src/implementation/my_firebase_service.dart';
import 'package:module_data/src/implementation/network_service_implementation.dart';

class ServiceProvider {
  static final _getIt = GetIt.I;
  static final instance = ServiceProvider();
  late FirebaseService firebaseService;
  late NetworkService networkService;

  void initialize({
    FirebaseService? firebaseService,
    NetworkService? networkService,
  }) {
    _getIt.registerSingleton<FirebaseService>(
      MyFirebaseService(), // FIREBASE SERVICE SWITCHER
      // DummyFirebaseService(),
    );
    this.firebaseService = firebaseService ?? _getIt.get<FirebaseService>();

    _getIt.registerSingleton<NetworkService>(
      NetworkServiceImplementation(),
    );
    this.networkService = networkService ?? _getIt.get<NetworkService>();
  }
}
