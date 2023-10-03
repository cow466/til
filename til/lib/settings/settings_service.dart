import 'package:flutter/material.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async => _readThemeMode();

  Future<ThemeMode> _readThemeMode() async {
    // Read settings from local storage
    return ThemeMode.system;
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    // Update settings in local storage
  }
}
