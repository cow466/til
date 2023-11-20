import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:til/features/authentication/data/auth_controller_provider.dart';
import 'package:til/features/authentication/data/firebase_auth_provider.dart';
import 'package:til/features/posts/presentation/home_view.dart';
import '../../user/data/user_db.dart';
import '../../user/data/user_db_provider.dart';
import '../../authentication/data/logged_in_user_provider.dart';

/// Presents the page containing fields to signup with a username and password, plus buttons.
class CreateAccountView extends ConsumerStatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  static const routeName = '/create-account';

  @override
  ConsumerState<CreateAccountView> createState() => SignUpViewState();
}

class SignUpViewState extends ConsumerState<CreateAccountView> {
  final _nameController = TextEditingController();
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
            Image.asset('images/til_logo.png', width: 150),
            const SizedBox(height: 16.0),
            Text(
              'Finish Creating Your Account',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
        const SizedBox(height: 20.0),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
        ),
        const SizedBox(height: 12.0),
        TextField(
          controller: _aboutMeController,
          decoration: const InputDecoration(
            labelText: 'About Me',
          ),
        ),
        const SizedBox(height: 12.0),
        ElevatedButton(
          onPressed: () {
            ref
                .read(authControllerProvider.notifier)
                .signInAs(
                  name: _nameController.text,
                  email: ref.watch(firebaseAuthProvider).currentUser!.email!,
                  aboutMe: _aboutMeController.text,
                  ref: ref,
                )
                .then((_) {
              context.go(HomeView.routeName);
            });
          },
          child: const Text('Sign up'),
        ),
      ],
    );
  }
}
