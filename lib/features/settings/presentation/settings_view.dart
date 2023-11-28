import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:til/features/authentication/data/auth_controller_provider.dart';
import 'package:til/features/firebase/data/firebase_auth_provider.dart';
import 'package:til/features/common/layouts/limited_layout.dart';
import 'package:til/features/loading/presentation/loading_view.dart';
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
                ref.read(authControllerProvider.notifier).signOut();
              },
            )
          ],
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const LoadingView(),
    };
  }
}
