import 'dart:convert';

import 'package:bomba_timer/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

enum AppPreference {
  settings("settings", defaultSettings);

  final String id;
  final dynamic defaultValue;

  const AppPreference(this.id, this.defaultValue);

  dynamic get() {
    String? json = sharedPreferences?.getString(id);
    if (json != null) {
      try {
        return SettingsModel.fromJson(jsonDecode(json));
      } catch (e) {
        debugPrint(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  Future set(newValue) async {
    return await sharedPreferences?.setString(
      id,
      jsonEncode((newValue as SettingsModel).toJson()),
    );
  }

  Future reset() async {
    await sharedPreferences?.setString(id, defaultValue);
  }
}

class AppPreferences {
  Future reset() async {
    await AppPreference.settings.reset();
  }

  Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
