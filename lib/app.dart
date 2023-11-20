import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:til/features/routing/router.dart';
import 'package:til/features/settings/data/settings_provider.dart';

class TILApp extends ConsumerWidget {
  const TILApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSettings = ref.watch(settingsNotifierProvider);

    if (asyncSettings is AsyncError) {
      throw Exception('asyncSettings error: ${asyncSettings.error}');
    } else if (asyncSettings is AsyncLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final settings = asyncSettings.asData!.value;
    final goRouter = ref.watch(goRouterProvider);
    return SafeArea(
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
          ),
          textTheme: TextTheme(
            bodyMedium: GoogleFonts.openSans(),
          ),
        ),
        darkTheme: ThemeData.dark(),
        themeMode: settings.themeMode,
        routerConfig: goRouter,
      ),
    );
  }
}
