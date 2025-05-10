//Text Theme
import 'package:flutter/material.dart';

extension BuildContextEntension<T> on BuildContext {
  ///TEXT
  TextStyle? get bodyDefault => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get textSmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get title => Theme.of(this).textTheme.titleLarge;
  TextStyle? get subTitle => Theme.of(this).textTheme.titleMedium;
  TextStyle? get headline => Theme.of(this).textTheme.headlineSmall;
  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  ///NAVIGATION
  pop({dynamic res}) {
    if (mounted && Navigator.of(this).canPop()) {
      Navigator.pop(this, res);
    }
  }

  Future push(Widget child, {String? name}) async {
    if (mounted) {
      return await Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) {
            return child;
          },
          settings: name == null ? null : RouteSettings(name: name),
        ),
      );
    }
  }
}
