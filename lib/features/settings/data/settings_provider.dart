import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/settings.dart';
import './settings_service.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  late SettingsService _settingsService;

  @override
  Future<Settings> build() async {
    var prefs = await SharedPreferences.getInstance();
    _settingsService = SettingsService(prefs: prefs);
    return Settings(
      themeMode: ThemeMode.system,
    );
  }

  Future<void> loadSettings() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      var themeMode = await _settingsService.readThemeMode();
      return Settings(
        themeMode: themeMode,
      );
    });
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    final prev = state.valueOrNull;
    if (prev == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _settingsService.updateThemeMode(newThemeMode);
      return prev.copyWith(themeMode: newThemeMode);
    });
  }
}
