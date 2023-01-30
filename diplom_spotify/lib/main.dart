import 'package:diplom_spotify/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';

void main() {
  BusinessLayer.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
