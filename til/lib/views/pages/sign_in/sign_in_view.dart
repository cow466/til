import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Sign in'),
      ],
    );
  }
}
