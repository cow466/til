import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import 'package:til/data/user_db.dart';
import 'package:til/settings/settings_controller.dart';
import 'package:til/settings/sign_in.dart';
import 'package:til/views/pages/friends/friends_view.dart';
import 'package:til/views/pages/home/home_view.dart';
import 'package:til/views/layouts/main_layout/main_page_layout.dart';
import 'package:til/views/pages/new_post/new_post_view.dart';
import 'package:til/views/pages/other_profile/other_profile_view.dart';
import 'package:til/views/pages/page_not_found/page_not_found_view.dart';
import 'package:til/views/pages/profile/profile_view.dart';
import 'package:til/views/pages/sign_in/sign_in_view.dart';

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
          // check signed in
          if (loggedInUser == null) {
            return const MainPageLayout(
              body: SignInView(),
            );
          }

          return MainPageLayout(
            body: child,
          );
        },
        routes: [
          GoRoute(
            path: HomeView.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeView(),
            ),
          ),
          GoRoute(
            path: NewPostView.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: NewPostView(),
            ),
          ),
          GoRoute(
            path: FriendsView.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FriendsView(),
            ),
          ),
          GoRoute(
            path: ProfileView.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileView(),
            ),
          ),
          GoRoute(
            path: OtherProfileView.routeName,
            pageBuilder: (context, state) {
              final id = state.pathParameters['id'];
              Widget child;
              if (id == null) {
                child = const PageNotFoundView();
              } else if (id == loggedInUser!.id) {
                child = const ProfileView();
              } else {
                final user = userDB.getById(id);
                child = OtherProfileView(user: user);
              }
              return NoTransitionPage(child: child);
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListenableBuilder(
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
      ),
    );
  }
}
