//Text Theme
import 'package:bomba_timer/helpers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  ///THEME
  bool get isDarkMode {
    try {
      return View.of(this).platformDispatcher.platformBrightness ==
          Brightness.dark;
    } catch (e) {
      return false;
    }
  }

  ///SYSTEM UI

  showBottomSheet({
    required String message,
    String? okString,
    Function? okButton,
  }) async {
    return await showModalBottomSheet(
      showDragHandle: true,
      context: this,

      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                gapH18,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    message,
                    style: context.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
                gapH18,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(okString ?? "Ok"),
                    onPressed: () {
                      if (okButton != null) {
                        okButton.call();
                      } else {
                        this.pop();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: Text("Annulla"),
                    onPressed: () {
                      this.pop();
                    },
                  ),
                ),
                gapH18,
              ],
            ),
          ),
        );
      },
    );
  }

  snackbar(String message, bool error) {
    if (!mounted) return;
    HapticFeedback.heavyImpact();
    ScaffoldMessenger.of(this).clearSnackBars();
    Color color = error ? Colors.red : Colors.green;

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            ScaffoldMessenger.of(this).clearSnackBars();
          },
          child: ListTile(
            tileColor:
                error ? Colors.red.withAlpha(30) : Colors.green.withAlpha(30),
            title: Text(message),
            leading: Icon(
              error ? Icons.warning : Icons.check_circle_outline,
              color: color,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: color, width: 3),
            ),
            onTap: () {
              ScaffoldMessenger.of(this).clearSnackBars();
            },
          ),
        ),
        elevation: 0,
        dismissDirection: DismissDirection.none,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

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
