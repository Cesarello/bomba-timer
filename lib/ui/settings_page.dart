import 'package:bomba_timer/helpers/app_preferences.dart';
import 'package:bomba_timer/helpers/context.dart';
import 'package:bomba_timer/helpers/theme.dart';
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
      appBar: AppBar(title: Text("Impostazioni")),
      body: PopScope(
        canPop: valueChanged(),
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          await context.showBottomSheet(
            message: "Vuoi tornare indietro senza salvare le modifiche?",
            okString: "Continua",
            okButton: () {
              context.pop();
              context.pop();
            },
          );
        },

        child: SafeArea(
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
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                try {
                  int.parse(minController.text);
                  int.parse(maxController.text);
                } catch (e) {
                  context.snackbar(
                    "Il valori inseriti non sono un numero valido",
                    true,
                  );
                  return;
                }
                if (minController.text.isEmpty || maxController.text.isEmpty) {
                  context.snackbar(
                    "I valori minimi e massimi non possono essere vuoti",
                    true,
                  );
                  return;
                }
                if (int.parse(minController.text) >
                    int.parse(maxController.text)) {
                  context.snackbar(
                    "Il valore minimo deve essere minore del valore massimo",
                    true,
                  );
                  return;
                }

                if (int.parse(maxController.text) > 200) {
                  context.snackbar(
                    "Il valore massimo non può essere maggiore di 200",
                    true,
                  );
                  return;
                }
                if (int.parse(minController.text) < 1) {
                  context.snackbar(
                    "Il valore minimo non può essere minore di 1",
                    true,
                  );
                  return;
                }
                saveValues(
                  minController.text,
                  maxController.text,
                  posiz,
                  sound,
                  vibration,
                  random,
                );
                context.pop();
                context.snackbar("Impostazioni salvate", false);
              },
              child: Text("Salva modifiche"),
            ),
            gapH18,
            TextButton(
              onPressed: () {
                context.showBottomSheet(
                  message:
                      "Sei sicuro di voler ripristinare i valori predefiniti?",
                  okString: "Ripristina",
                  okButton: () {
                    AppPreferences().reset();
                    context.pop();
                    context.pop();
                  },
                );
                context.snackbar("Impostazioni ripristinate", false);
              },
              child: Text("Ripristina valori predefiniti"),
            ),
          ],
        ),
      ],
    );
  }

  valueChanged() {
    SettingsModel sett = (AppPreference.settings.get() as SettingsModel);
    return !(sett.min.toString() != minController.text ||
        sett.max.toString() != maxController.text ||
        sett.vibration != vibration ||
        sett.sound != sound ||
        sett.sillaba != random ||
        sett.posiz != posiz);
  }
}
