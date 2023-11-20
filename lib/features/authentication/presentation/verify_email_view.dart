import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:til/features/authentication/presentation/create_account_view.dart';
import 'package:til/features/common/layouts/limited_layout.dart';
import './sign_in_view.dart';

/// Builds the page to support email verification.
class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  static const routeName = '/verify-email';

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
      headerBuilder: (context, constraints, shrinkOffset) =>
          const Icon(Icons.verified),
      sideBuilder: (context, constraints) => const Icon(Icons.verified),
      actions: [
        EmailVerifiedAction(() {
          context.go(LimitedPageLayout.routeName + CreateAccountView.routeName);
        }),
        AuthCancelledAction((context) {
          FirebaseUIAuth.signOut(context: context);
          context.go(LimitedPageLayout.routeName + SignInView.routeName);
        }),
      ],
    );
  }
}
