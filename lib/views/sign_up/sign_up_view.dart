import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:til/views/pages/home/home_view.dart';

/// Presents the page containing fields to signup with a username and password, plus buttons.
class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  static const routeName = '/sign-up';

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: <Widget>[
        const SizedBox(height: 40.0),
        Column(
          children: <Widget>[
            // Image.asset('assets/images/vegetables.png', width: 100),
            // const SizedBox(height: 16.0),
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
        const SizedBox(height: 20.0),
        // [Name]
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
        ),
        const SizedBox(height: 12.0),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
        ),
        const SizedBox(height: 12.0),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
        ),
        const SizedBox(height: 12.0),
        TextField(
          controller: _mobileController,
          decoration: const InputDecoration(
            labelText: 'Mobile',
          ),
        ),
        const SizedBox(height: 12.0),
        ElevatedButton(
          onPressed: () {
            context.go(HomeView.routeName);
          },
          child: const Text('Sign up'),
        ),
      ],
    );
  }
}
