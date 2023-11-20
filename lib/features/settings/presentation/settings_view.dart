import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:til/features/authentication/data/firebase_auth_provider.dart';
import '../data/settings_provider.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSettings = ref.watch(settingsNotifierProvider);

    return switch (asyncSettings) {
      AsyncData(:final value) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          shrinkWrap: true,
          children: [
            Switch(
              value: value.themeMode == ThemeMode.dark,
              onChanged: (value) {
                ref
                    .read(settingsNotifierProvider.notifier)
                    .updateThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
            TextButton(
              child: const Text('Sign out'),
              onPressed: () {
                ref.watch(firebaseAuthProvider).signOut();
              },
            )
          ],
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
