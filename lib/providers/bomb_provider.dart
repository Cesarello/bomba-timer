import 'dart:math';

import 'package:bomba_timer/helpers/app_preferences.dart';

import '../models/settings_model.dart';

saveValues(
  String min,
  String max,
  bool pos,
  bool suono,
  bool vibr,
  bool sill,
  bool fl,
) {
  AppPreference.settings.set(
    SettingsModel(
      min: int.parse(min),
      max: int.parse(max),
      posiz: pos,
      sound: suono,
      vibration: vibr,
      sillaba: sill,
      flash: fl,
    ),
  );
}

int slowDuration(SettingsModel sett) {
  final random = Random();
  return sett.min + random.nextInt(sett.max - sett.min);
}

int fastDuration() {
  final random = Random();
  return 5 + random.nextInt(20 - 5);
}

SettingsModel defaultSettings = SettingsModel(
  sound: true,
  vibration: true,
  sillaba: true,
  posiz: true,
  min: 15,
  max: 90,
  flash: false,
);
