import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class Settings with _$Settings {
  factory Settings({
    required ThemeMode themeMode,
  }) = _Settings;

  factory Settings.fromJson(Map<String, Object?> json) =>
      _$SettingsFromJson(json);
}
