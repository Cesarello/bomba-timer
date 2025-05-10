import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bomba_timer/helpers/app_preferences.dart';
import 'package:bomba_timer/helpers/context.dart';
import 'package:bomba_timer/helpers/lists.dart';
import 'package:bomba_timer/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:vibration/vibration.dart';

import '../helpers/theme.dart';
import '../providers/bomb_provider.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    AppTheme.adaptiveStatusBar(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('slow.mp3'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledText(
                text: getPosiz(),
                style: context.title,
                tags: {
                  'b': StyledTextTag(
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                },
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    isPlaying ? 'assets/bomb-on.png' : 'assets/bomb-off.png',
                  ),
                  Transform.translate(
                    offset: const Offset(0, 20),
                    child: Text(
                      getSillaba(),
                      style: context.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              ElevatedButton(
                onPressed: () async {
                  isPlaying ? await player.stop() : startSound();
                  isPlaying = !isPlaying;
                  setState(() {});
                },
                child: Text(isPlaying ? "Stop" : "Inizia"),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        TextButton(
          onPressed:
              isPlaying
                  ? null
                  : () {
                    context.push(SettingsPage());
                  },
          child: Text("Impostazioni"),
        ),
      ],
    );
  }

  startSound() async {
    if ((AppPreference.settings.get() as SettingsModel).sound) {
      await player.setSource(AssetSource('slow.mp3'));
      await player.resume();
      if (!mounted) return;
      await Future.delayed(Duration(seconds: slowDuration()));
      await player.stop();
      if (!isPlaying) return;
      await player.setSource(AssetSource('fast.mp3'));
      await player.resume();
      if (!mounted) return;
      await Future.delayed(Duration(seconds: fastDuration()));
      await player.stop();
      if (!isPlaying) return;
      await player.setSource(AssetSource('explosion.mp3'));
      await player.resume();
    } else {
      await Future.delayed(Duration(seconds: slowDuration()));
      await Future.delayed(Duration(seconds: fastDuration()));
    }
    if (!isPlaying) return;
    if ((AppPreference.settings.get() as SettingsModel).vibration) {
      Vibration.vibrate(duration: 1500);
    }
    isPlaying = false;
    setState(() {});
  }

  String getSillaba() {
    if (!isPlaying) return "";
    if ((AppPreference.settings.get() as SettingsModel).sillaba) {
      return sillabe[Random().nextInt(sillabe.length)].toUpperCase();
    }
    return "";
  }

  String getPosiz() {
    if (!isPlaying) return "";
    if ((AppPreference.settings.get() as SettingsModel).posiz) {
      return positions[Random().nextInt(3)];
    }
    return "";
  }
}
