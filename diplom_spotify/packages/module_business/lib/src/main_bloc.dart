import 'package:module_data/module_data.dart';

class MainBloc {
  final FirebaseService firebaseService;
  final NetworkService networkService;

  MainBloc({
    required this.firebaseService,
    required this.networkService,
  });
}
