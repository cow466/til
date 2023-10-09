import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import 'package:til/settings/settings_controller.dart';
import 'package:til/views/pages/friends/friends_view.dart';
import 'package:til/views/pages/home/home_view.dart';
import 'package:til/views/layouts/main_layout/main_page_layout.dart';
import 'package:til/views/pages/new_post/new_post_view.dart';
import 'package:til/views/pages/page_not_found/page_not_found_view.dart';
import 'package:til/views/pages/profile/profile_view.dart';

class TILApp extends StatelessWidget {
  TILApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  final _router = GoRouter(
    initialLocation: HomeView.routeName,
    errorBuilder: (context, state) => const MainPageLayout(
      body: PageNotFoundView(),
    ),
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainPageLayout(
            body: child,
          );
        },
        routes: [
          GoRoute(
            path: HomeView.routeName,
            builder: (context, state) => const HomeView(),
          ),
          GoRoute(
            path: NewPostView.routeName,
            builder: (context, state) => const NewPostView(),
          ),
          GoRoute(
            path: FriendsView.routeName,
            builder: (context, state) => const FriendsView(),
          ),
          GoRoute(
            path: ProfileView.routeName,
            builder: (context, state) => const ProfileView(),
          )
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (context, child) => MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
          ),
          textTheme: TextTheme(
            bodyMedium: GoogleFonts.openSans(),
          ),
        ),
        darkTheme: ThemeData.dark(),
        themeMode: settingsController.themeMode,
        routerConfig: _router,
      ),
    );
  }
}
