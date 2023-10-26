import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:til/settings/settings.dart';
import 'package:til/settings/sign_in.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      shrinkWrap: true,
      children: [
        Switch(
          value: ref.read(settingsNotifierProvider).themeMode == ThemeMode.dark,
          onChanged: (value) {
            ref
                .read(settingsNotifierProvider.notifier)
                .updateThemeMode(value ? ThemeMode.dark : ThemeMode.light);
          },
        ),
        TextButton(
          child: const Text('Sign out'),
          onPressed: () {
            ref.read(loggedInUserNotifierProvider.notifier).signOut();
          },
        )
      ],
    );
  }
}
