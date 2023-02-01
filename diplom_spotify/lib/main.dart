import 'package:diplom_spotify/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BusinessLayer.instance.initialize();
  runApp(const App());
}
