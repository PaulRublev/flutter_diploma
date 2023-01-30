import 'package:module_data/module_data.dart';

class BusinessLayer {
  static final instance = BusinessLayer();

  void initialize() {
    ServiceProvider.instance.initialize();
  }
}
