import 'package:bomba_timer/helpers/theme.dart';
import 'package:bomba_timer/ui/flash_overlay.dart';
import 'package:flutter/material.dart';

import 'helpers/app_preferences.dart';
import 'ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().init();
  AppTheme.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final WhiteFlashController controller = WhiteFlashController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().light(),
      darkTheme: AppTheme().dark(),
      home: WhiteFlashOverlay(
        controller: controller,
        child: HomePage(flashController: controller),
      ),
    );
  }
}
