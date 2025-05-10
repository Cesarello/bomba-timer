import 'dart:math';

import 'package:bomba_timer/helpers/app_preferences.dart';

import '../models/settings_model.dart';

saveValues(String min, String max, bool pos, bool suono, bool vibr, bool sill) {
  AppPreference.settings.set(
    SettingsModel(
      min: int.parse(min),
      max: int.parse(max),
      posiz: pos,
      sound: suono,
      vibration: vibr,
      sillaba: sill,
    ),
  );
}

int slowDuration() {
  SettingsModel sett = (AppPreference.settings.get() as SettingsModel);
  final random = Random();
  return sett.min + random.nextInt(sett.max - sett.min);
}

int fastDuration() {
  final random = Random();
  return 5 + random.nextInt(20 - 5);
}
