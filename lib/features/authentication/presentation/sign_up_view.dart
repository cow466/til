import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/domain/user_db.dart';
import '../../user/data/user_db_provider.dart';
import '../../authentication/data/logged_in_user_provider.dart';

/// Presents the page containing fields to signup with a username and password, plus buttons.
class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  static const routeName = '/sign-up';

  @override
  ConsumerState<SignUpView> createState() => SignUpViewState();
}

class SignUpViewState extends ConsumerState<SignUpView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _aboutMeController = TextEditingController();

  late UserDB userDB;

  @override
  void initState() {
    super.initState();
    userDB = ref.read(userDBProvider);
  }

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
          controller: _nameController,
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
          controller: _aboutMeController,
          decoration: const InputDecoration(
            labelText: 'Mobile',
          ),
        ),
        const SizedBox(height: 12.0),
        ElevatedButton(
          onPressed: () {
            final newId = ref.read(userDBProvider).signUpWith(
                name: _nameController.text,
                email: _emailController.text,
                aboutMe: _aboutMeController.text);
            if (newId == null) {
              // fail
              return;
            }
            final newUser = ref.read(userDBProvider).getById(newId);
            ref.read(loggedInUserNotifierProvider.notifier).signInAs(
                  email: newUser.email,
                  password: '',
                  ref: ref,
                );
          },
          child: const Text('Sign up'),
        ),
      ],
    );
  }
}
