import 'package:bomba_timer/helpers/theme.dart';
import 'package:flutter/material.dart';

import 'helpers/app_preferences.dart';
import 'ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().init();
  AppTheme.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().light(),
      darkTheme: AppTheme().dark(),
      home: HomePage(),
    );
  }
}
