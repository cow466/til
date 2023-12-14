import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/authentication/data/auth_controller_provider.dart';
import 'package:til/features/authentication/data/logged_in_user_provider.dart';
import 'package:til/features/images/presentation/crop_image_screen.dart';
import 'package:til/features/images/presentation/display_picture_screen.dart';
import 'package:til/features/images/presentation/take_picture_screen.dart';
import 'package:til/features/organization/presentation/organization_profile.dart';
import 'package:til/features/user/domain/user.dart';
import 'package:til/features/user/presentation/search_user_view.dart';
import '../firebase/data/firebase_auth_provider.dart';
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
  final authUserAsync = ref.watch(authStateChangesProvider);
  final loggedInUserAsync = ref.watch(loggedInUserProvider);

  String initialLocation = LimitedPageLayout.routeName + SignInView.routeName;
  if (authUserAsync is AsyncData) {
    if (authUserAsync.asData!.hasValue && authUserAsync.asData!.value != null) {
      if (loggedInUserAsync is AsyncData &&
          loggedInUserAsync.asData!.hasValue &&
          loggedInUserAsync.asData!.value == null) {
        initialLocation =
            LimitedPageLayout.routeName + CreateAccountView.routeName;
      } else {
        initialLocation = HomeView.routeName;
      }
    }
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
            path: OrganizationProfileView.routeName,
            parentNavigatorKey: mainShellNavigatorKey,
            pageBuilder: (context, state) {
              final id = state.pathParameters['id'];
              Widget child;
              if (id == null) {
                child = const PageNotFoundView();
              } else {
                child = OrganizationProfileView(id: id);
              }
              return NoTransitionPage(child: child);
            },
          ),
          GoRoute(
            path: SearchUserView.routeName,
            parentNavigatorKey: mainShellNavigatorKey,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SearchUserView(),
            ),
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
      GoRoute(
        path: LimitedPageLayout.routeName + SignInView.routeName,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: SignInView());
        },
      ),
      GoRoute(
        path: LimitedPageLayout.routeName + VerifyEmailView.routeName,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: VerifyEmailView());
        },
      ),
      GoRoute(
        path: LimitedPageLayout.routeName + CreateAccountView.routeName,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final stepParam = state.pathParameters['step'];
          final parsedStep = int.tryParse(stepParam ?? '');
          final roleParam = state.pathParameters['role'];
          final parsedRole = switch (roleParam) {
            String() =>
              Role.values.firstWhere((e) => e.toString() == 'Role.$roleParam'),
            null => null,
          };
          return NoTransitionPage(
            child: CreateAccountView(
              step: parsedStep,
              role: parsedRole,
              imagePath: (state.extra is String ? state.extra as String : null),
            ),
          );
        },
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
                _ => const NoTransitionPage(
                    child: PageNotFoundView(),
                  ),
              };
              return child;
            },
          ),
        ],
      ),
      GoRoute(
        path: TakePictureScreen.routeName,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: TakePictureScreen(),
          );
        },
      ),
      GoRoute(
        path: DisplayPictureScreen.routeName,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
              child: DisplayPictureScreen(
            imagePath: state.extra! as String,
          ));
        },
      ),
      GoRoute(
        path: CropImageScreen.routeName,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
              child: CropImageScreen(
            file: state.extra as XFile?,
          ));
        },
      ),
    ],
  );
}
