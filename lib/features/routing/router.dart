import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/authentication/data/auth_controller_provider.dart';
import 'package:til/features/authentication/data/logged_in_user_provider.dart';
import '../authentication/data/firebase_auth_provider.dart';
import '../authentication/presentation/create_account_view.dart';
import '../authentication/presentation/sign_in_view.dart';
import '../authentication/presentation/verify_email_view.dart';
import '../common/layouts/limited_layout.dart';
import '../common/layouts/main_page_layout.dart';
import '../error/presentation/page_not_found_view.dart';
import '../friends/presentation/friends_view.dart';
import '../posts/presentation/home_view.dart';
import '../posts/presentation/new_post_view.dart';
import '../settings/presentation/settings_view.dart';
import '../user/presentation/other_profile_view.dart';
import '../user/presentation/profile_view.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final mainShellNavigatorKey = GlobalKey<NavigatorState>();
  final limitedShellNavigatorKey = GlobalKey<NavigatorState>();

  ref.watch(authControllerProvider);
  final authUser = ref.watch(authStateChangesProvider).valueOrNull;
  final isLoggedIn = authUser != null;
  final loggedInUser = ref.watch(loggedInUserProvider).valueOrNull;
  final hasUserData = loggedInUser != null;

  String initialLocation;
  if (!isLoggedIn) {
    initialLocation = LimitedPageLayout.routeName + SignInView.routeName;
  } else if (!hasUserData) {
    initialLocation = LimitedPageLayout.routeName + CreateAccountView.routeName;
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
                SignInView.routeName => const NoTransitionPage(
                    child: SignInView(),
                  ),
                VerifyEmailView.routeName => const NoTransitionPage(
                    child: VerifyEmailView(),
                  ),
                CreateAccountView.routeName => const NoTransitionPage(
                    child: CreateAccountView(),
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
