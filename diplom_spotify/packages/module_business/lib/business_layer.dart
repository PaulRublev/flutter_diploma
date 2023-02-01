import 'package:module_data/module_data.dart';

class BusinessLayer {
  static final instance = BusinessLayer();

  Future<void> initialize() async {
    ServiceProvider.instance.initialize();
    await ServiceProvider.instance.firebaseService.firebaseInit();
    ServiceProvider.instance.firebaseService.referenceInit();
  }
}
