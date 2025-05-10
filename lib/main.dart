import 'package:flutter/material.dart';

import 'helpers/app_preferences.dart';
import 'ui/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
