import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/settings.dart';
import '../../authentication/data/logged_in_user_provider.dart';

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
