import 'package:bomba_timer/helpers/context.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const nullBox = SizedBox();
const gapH8 = SizedBox(height: 8);
const gapW8 = SizedBox(width: 8);
const gapH18 = SizedBox(height: 18);
const gapW18 = SizedBox(width: 18);

const paddingHoriz8 = EdgeInsets.symmetric(horizontal: 8);
const paddingHoriz18 = EdgeInsets.symmetric(horizontal: 18);
const paddingHoriz18Vert8 = EdgeInsets.symmetric(horizontal: 18, vertical: 8);
const paddingVert8 = EdgeInsets.symmetric(vertical: 8);
const paddingVert18 = EdgeInsets.symmetric(vertical: 18);
const paddingAll4 = EdgeInsets.all(4);
const paddingAll8 = EdgeInsets.all(8);
const paddingAll18 = EdgeInsets.all(18);

const divider = Divider(
  color: Color(0x40BEBEBE), //per avere const Colors.grey.withOpacity(0.25)
  thickness: 0.5,
);
const divider18 = Divider(
  color: Color(0x40BEBEBE), //per avere const Colors.grey.withOpacity(0.25)
  thickness: 0.5,
  indent: 18,
  endIndent: 18,
);

const SystemUiOverlayStyle systemUiOverlayStyleLight = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  //Only honored in Android versions O and greater.
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
  //Only honored in Android version M and greater.
  statusBarIconBrightness: Brightness.dark,
  //Only honored in Android version Q and greater.
  systemNavigationBarContrastEnforced: true,
  //Only honored in iOS.
  statusBarBrightness: Brightness.light,
);

const SystemUiOverlayStyle systemUiOverlayStyleDark = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  //Only honored in Android versions O and greater.
  systemNavigationBarColor: Colors.black,
  systemNavigationBarIconBrightness: Brightness.light,
  //Only honored in Android version M and greater.
  statusBarIconBrightness: Brightness.light,
  //Only honored in Android version Q and greater.
  systemNavigationBarContrastEnforced: true,
  //Only honored in iOS.
  statusBarBrightness: Brightness.dark,
);

Color primaryColor = Colors.deepOrange.shade800;
Color primaryLight = const Color(0xFFffd651);

class AppTheme {
  const AppTheme();
  static ColorScheme lightScheme() {
    return ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: primaryColor,
      primary: primaryColor,
      onPrimary: const Color(0xFFFFFFFF),
      secondary: primaryColor,
      surface: const Color(0xFFF5F5F5),
      onSurface: const Color(0xFF333333),
      surfaceBright: const Color.fromARGB(255, 228, 228, 228),
      tertiaryContainer: const Color(0xFFC8DFEE),
    );
  }

  ThemeData light() => theme(lightScheme());

  static ColorScheme darkScheme() {
    return ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: primaryColor,
      primary: primaryColor,
      onPrimary: const Color(0xFFFFFFFF),
      secondary: primaryColor,
      surface: const Color(0xFF181A1B),
      onSurface: const Color(0xFFF4F4F4),
      surfaceBright: const Color(0xFF444444),
      tertiaryContainer: const Color(0xFF314A5B),
    );
  }

  ThemeData dark() => theme(darkScheme());

  ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),

      dividerTheme: DividerThemeData(color: Colors.transparent),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 0),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          textStyle: TextStyle(fontWeight: FontWeight.bold),
          padding: paddingAll18,
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.secondary;
          }
          return Colors.grey;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.secondary.withAlpha(125);
          }
          return colorScheme.onSurface.withAlpha(125);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          return colorScheme.surfaceBright.withAlpha(125);
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          visualDensity: VisualDensity.compact,
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static Future init() async {
    GestureBinding.instance.resamplingEnabled = true;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyleDark);
  }

  static adaptiveStatusBar(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    Future.microtask(() async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
      );
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        isDarkMode
            ? systemUiOverlayStyleDark.copyWith(
              systemNavigationBarColor: Colors.black.withAlpha(1),
              //colors.transparent non funziona con la barra di navigazione coi tasti
            )
            : systemUiOverlayStyleLight.copyWith(
              systemNavigationBarColor: Colors.white.withAlpha(1),
              //colors.transparent non funziona con la barra di navigazione coi tasti
            ),
      );
      WidgetsBinding.instance.renderViews.first.automaticSystemUiAdjustment =
          false;
    });
  }
}
