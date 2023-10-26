import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import './settings_service.dart';

part 'settings.g.dart';

class Settings {
  final ThemeMode themeMode;
  Settings({
    required this.themeMode,
  });
  Settings copyWith({ThemeMode? themeMode}) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  final SettingsService _settingsService = SettingsService();

  @override
  Settings build() {
    return Settings(
      themeMode: ThemeMode.system,
    );
  }

  Future<void> loadSettings() async {
    state = Settings(
      themeMode: await _settingsService.themeMode(),
    );
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == state.themeMode) return;

    await _settingsService.updateThemeMode(newThemeMode);

    state = state.copyWith(
      themeMode: newThemeMode,
    );
  }
}
