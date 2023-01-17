import 'main_bloc.dart';
import 'package:module_data/module_data.dart';

class BlocFactory {
  static final instance = BlocFactory();

  late final MainBloc mainBloc;

  void initialize() {
    ServiceProvider.instance.initialize();
    mainBloc = MainBloc(
      firebaseService: ServiceProvider.instance.get<FirebaseService>(),
    );
  }
}
