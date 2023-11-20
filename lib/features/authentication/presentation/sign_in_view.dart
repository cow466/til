import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ForgotPasswordView;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:til/features/authentication/data/logged_in_user_provider.dart';
import 'package:til/features/authentication/presentation/create_account_view.dart';
import 'package:til/features/authentication/presentation/verify_email_view.dart';
import 'package:til/features/posts/presentation/home_view.dart';
import 'package:til/features/user/data/user_db_provider.dart';
import './forgot_password_view.dart';
import '../../common/layouts/limited_layout.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SignInScreen(
        providers: [EmailAuthProvider()],
        headerBuilder: (context, constraints, shrinkOffset) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              'images/til_logo.png',
            ),
          );
        },
        sideBuilder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              'images/til_logo.png',
            ),
          );
        },
        footerBuilder: (context, action) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextButton(
              onPressed: () {
                context.go(LimitedPageLayout.routeName + HomeView.routeName);
              },
              child: const Text('Continue as guest'),
            ),
          );
        },
        actions: [
          ForgotPasswordAction((context, email) {
            context.push(ForgotPasswordView.routeName);
          }),
          AuthStateChangeAction<SignedIn>((context, state) {
            if (!state.user!.emailVerified) {
              context
                  .go(LimitedPageLayout.routeName + VerifyEmailView.routeName);
            } else {
              context.go(HomeView.routeName);
            }
          }),
          AuthStateChangeAction<UserCreated>((context, state) {
            if (!state.credential.user!.emailVerified) {
              context
                  .go(LimitedPageLayout.routeName + VerifyEmailView.routeName);
            } else {
              context.go(
                  LimitedPageLayout.routeName + CreateAccountView.routeName);
            }
          }),
          AuthStateChangeAction<CredentialLinked>((context, state) {
            if (!state.user.emailVerified) {
              context
                  .go(LimitedPageLayout.routeName + VerifyEmailView.routeName);
            } else {
              context.go(HomeView.routeName);
            }
          }),
        ],
        headerMaxExtent: 250,
        showPasswordVisibilityToggle: true,
      ),
    );
  }
}
