class SettingsModel {
  int min, max;
  bool posiz, sound, vibration, sillaba, flash;

  SettingsModel({
    required this.min,
    required this.max,
    required this.posiz,
    required this.sound,
    required this.vibration,
    required this.sillaba,
    required this.flash,
  });

  static SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      min: json['min'] ?? 15,
      max: json['max'] ?? 90,
      posiz: json['posiz'] ?? true,
      sound: json['sound'] ?? true,
      vibration: json['vibration'] ?? true,
      sillaba: json['sillaba'] ?? true,
      flash: json['flash'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
      'posiz': posiz,
      'sound': sound,
      'vibration': vibration,
      'sillaba': sillaba,
      'flash': flash,
    };
  }
}

const String defaultSettings = '''
{
  "min": 15,
  "max": 90,
  "posiz": true,
  "sound": true,
  "vibration": true,
  "sillaba": true,
  "flash": false
}
''';
