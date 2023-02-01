import 'package:module_data/module_data.dart';

import 'mock_firebase_service.dart';
import 'mock_network_service.dart';

class MockBusinessLayer {
  static final instance = MockBusinessLayer();
  final FirebaseService firebaseService = MockFirebaseService();
  final NetworkService networkService = MockNetworkService();

  Future<void> initialize() async {
    ServiceProvider.instance.initialize(
      firebaseService: MockBusinessLayer.instance.firebaseService,
      networkService: MockBusinessLayer.instance.networkService,
    );
    await ServiceProvider.instance.firebaseService.firebaseInit();
    ServiceProvider.instance.firebaseService.referenceInit();
  }
}
