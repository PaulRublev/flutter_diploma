import 'package:diplom_spotify/src/widgets/utility_widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';

void main() async {
  BlocFactory.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await BlocFactory.instance.mainBloc.firebaseService.firebaseInit();
  BlocFactory.instance.mainBloc.firebaseService.referenceInit();
  runApp(const App());
}
