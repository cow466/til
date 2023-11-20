import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  SharedPreferences prefs;

  SettingsService({
    required this.prefs,
  });

  Future<ThemeMode> readThemeMode() async {
    var themeMode = switch (prefs.get('themeMode')) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.system,
    };
    return themeMode;
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    var themeModeString = switch (theme) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    prefs.setString('themeMode', themeModeString);
  }
}
