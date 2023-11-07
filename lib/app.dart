import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import 'package:til/features/user/domain/user.dart';
import 'package:til/features/settings/data/settings.dart';
import 'package:til/features/authentication/data/logged_in_user_provider.dart';
import 'package:til/features/common/layouts/limited_layout.dart';
import 'package:til/features/friends/presentation/friends_view.dart';
import 'package:til/features/posts/presentation/home_view.dart';
import 'package:til/features/common/layouts/main_page_layout.dart';
import 'package:til/features/posts/presentation/new_post_view.dart';
import 'package:til/features/user/presentation/other_profile_view.dart';
import 'package:til/features/error/presentation/page_not_found_view.dart';
import 'package:til/features/user/presentation/profile_view.dart';
import 'package:til/features/settings/presentation/settings_view.dart';
import 'package:til/features/authentication/presentation/sign_in_view.dart';
import 'package:til/features/authentication/presentation/sign_up_view.dart';

class TILApp extends ConsumerWidget {
  const TILApp({
    super.key,
  });

  _createRouter(User? loggedInUser) {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final mainShellNavigatorKey = GlobalKey<NavigatorState>();
    final limitedShellNavigatorKey = GlobalKey<NavigatorState>();

    String initialLocation;
    if (loggedInUser == null) {
      initialLocation = LimitedPageLayout.routeName + SignInView.routeName;
    } else {
      initialLocation = HomeView.routeName;
    }

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: initialLocation,
      errorBuilder: (context, state) => const MainPageLayout(
        body: PageNotFoundView(),
      ),
      routes: [
        ShellRoute(
          navigatorKey: mainShellNavigatorKey,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state, child) {
            return MainPageLayout(
              body: child,
            );
          },
          routes: [
            GoRoute(
              path: HomeView.routeName,
              parentNavigatorKey: mainShellNavigatorKey,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeView(),
              ),
            ),
            GoRoute(
              path: NewPostView.routeName,
              parentNavigatorKey: mainShellNavigatorKey,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: NewPostView(),
              ),
            ),
            GoRoute(
              path: FriendsView.routeName,
              parentNavigatorKey: mainShellNavigatorKey,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: FriendsView(),
              ),
            ),
            GoRoute(
              path: ProfileView.routeName,
              parentNavigatorKey: mainShellNavigatorKey,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfileView(),
              ),
            ),
            GoRoute(
              path: OtherProfileView.routeName,
              parentNavigatorKey: mainShellNavigatorKey,
              pageBuilder: (context, state) {
                final id = state.pathParameters['id'];
                Widget child;
                if (id == null) {
                  child = const PageNotFoundView();
                } else if (id == loggedInUser!.id) {
                  child = const ProfileView();
                } else {
                  child = OtherProfileView(id: id);
                }
                return NoTransitionPage(child: child);
              },
            ),
            GoRoute(
              path: SettingsView.routeName,
              parentNavigatorKey: mainShellNavigatorKey,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsView(),
              ),
            ),
          ],
        ),
        ShellRoute(
          navigatorKey: limitedShellNavigatorKey,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state, child) {
            return LimitedPageLayout(
              body: child,
            );
          },
          routes: [
            GoRoute(
              path: '${LimitedPageLayout.routeName}/:subpath',
              parentNavigatorKey: limitedShellNavigatorKey,
              pageBuilder: (context, state) {
                final subpath = '/${state.pathParameters['subpath']}';
                final child = switch (subpath) {
                  HomeView.routeName => const NoTransitionPage(
                      child: HomeView(),
                    ),
                  SignInView.routeName => NoTransitionPage(
                      child: SignInView(),
                    ),
                  SignUpView.routeName => const NoTransitionPage(
                      child: SignUpView(),
                    ),
                  _ => const NoTransitionPage(
                      child: PageNotFoundView(),
                    ),
                };
                return child;
              },
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsNotifierProvider);

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
        themeMode: ref.read(settingsNotifierProvider).themeMode,
        routerConfig: _createRouter(ref.watch(loggedInUserNotifierProvider)),
      ),
    );
  }
}
