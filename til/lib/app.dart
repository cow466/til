import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:til/pages/home/home_view.dart';

import 'package:til/settings/settings_controller.dart';
import 'package:til/pages/page_not_found/page_not_found_view.dart';

class TILApp extends StatelessWidget {
  const TILApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
          ),
          textTheme: TextTheme(
            bodyMedium: GoogleFonts.openSans(),
          ),
        ),
        darkTheme: ThemeData.dark(),
        themeMode: settingsController.themeMode,
        onGenerateRoute: (routeSettings) => MaterialPageRoute(
          settings: routeSettings,
          builder: (context) {
            switch (routeSettings.name) {
              case '/':
                return const HomeView();
              default:
                return const PageNotFoundView();
            }
          },
        ),
      ),
    );
  }
}
