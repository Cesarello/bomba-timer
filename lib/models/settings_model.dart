class SettingsModel {
  int min, max;
  bool posiz, sound, vibration, sillaba;

  SettingsModel({
    required this.min,
    required this.max,
    required this.posiz,
    required this.sound,
    required this.vibration,
    required this.sillaba,
  });

  static SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      min: json['min'] ?? 15,
      max: json['max'] ?? 90,
      posiz: json['posiz'] ?? true,
      sound: json['sound'] ?? true,
      vibration: json['vibration'] ?? true,
      sillaba: json['sillaba'] ?? true,
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
  "sillaba": true
}
''';
