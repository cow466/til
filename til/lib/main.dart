import 'package:flutter/material.dart';
import 'package:til/app.dart';
import 'package:til/settings/settings_controller.dart';
import 'package:til/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(TILApp(settingsController: settingsController));
}
