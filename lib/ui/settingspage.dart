import 'package:bomba_timer/helpers/app_preferences.dart';
import 'package:bomba_timer/helpers/context.dart';
import 'package:bomba_timer/models/settings_model.dart';
import 'package:bomba_timer/providers/bomb_provider.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  bool vibration = true, sound = true, random = true, posiz = true;

  @override
  void initState() {
    SettingsModel sett = (AppPreference.settings.get() as SettingsModel);
    minController.text = sett.min.toString();
    maxController.text = sett.max.toString();
    vibration = sett.vibration;
    sound = sett.sound;
    random = sett.sillaba;
    posiz = sett.posiz;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18.0),
          children: [
            ListTile(
              title: Text("Suono"),
              trailing: Switch(
                value: sound,
                onChanged: (value) {
                  setState(() => sound = value);
                },
              ),
            ),
            ListTile(
              title: Text("Vibrazione"),
              trailing: Switch(
                value: vibration,
                onChanged: (value) {
                  setState(() => vibration = value);
                },
              ),
            ),
            ListTile(
              title: Text("Mostra sillabe"),
              trailing: Switch(
                value: random,
                onChanged: (value) {
                  setState(() => random = value);
                },
              ),
            ),
            ListTile(
              title: Text("Mostra posizione"),
              trailing: Switch(
                value: posiz,
                onChanged: (value) {
                  setState(() => posiz = value);
                },
              ),
            ),
            ListTile(
              title: Text("Durata minima (secondi)"),
              trailing: SizedBox(
                width: 50,
                child: TextField(
                  controller: minController,
                  keyboardType: TextInputType.number,

                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("Durata massima (secondi)"),
              trailing: SizedBox(
                width: 50,
                child: TextField(
                  controller: maxController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                AppPreferences().reset();
                context.pop();
              },
              child: Text("Ripristina valori di default"),
            ),
            ElevatedButton(
              onPressed: () {
                saveValues(
                  minController.text,
                  maxController.text,
                  posiz,
                  sound,
                  vibration,
                  random,
                );
                context.pop();
              },
              child: Text("Salva modifiche"),
            ),
          ],
        ),
      ],
    );
  }
}
