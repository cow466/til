import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import '../../user/data/user_db.dart';
import '../../user/data/user_db_provider.dart';
import '../../authentication/data/logged_in_user_provider.dart';
import '../../authentication/presentation/sign_up_view.dart';
import '../../common/layouts/limited_layout.dart';

class SignInView extends ConsumerWidget {
  SignInView({super.key});

  static const routeName = '/sign-in';
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        shrinkWrap: true,
        children: [
          const SizedBox(height: 40.0),
          Column(
            children: <Widget>[
              // Image.asset('assets/images/vegetables.png', width: 100),
              // const SizedBox(height: 16.0),
              Text(
                'LARGE LOGO',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 120.0),
          // [Name]
          FormBuilder(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    // FormBuilderValidators.required(),
                  ]),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Forgot Password?'),
            ),
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  bool validEmailAndPassword =
                      _formKey.currentState?.saveAndValidate() ?? false;
                  UserDB userDB = ref.watch(userDBProvider);

                  if (validEmailAndPassword) {
                    String email = _formKey.currentState?.value['email'];
                    // String password = _formKey.currentState?.value['password'];
                    if (userDB.isUserEmail(email)) {
                      ref.read(loggedInUserNotifierProvider.notifier).signInAs(
                            email: email,
                            // password: password,
                            password: '',
                            ref: ref,
                          );
                      // Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Invalid email'),
                        duration: Duration(seconds: 10),
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Invalid Email or Password.'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                child: const Text('Sign in')),
          ),
          const SizedBox(height: 12.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Don't have an account? "),
            TextButton(
              child: const Text('Sign up'),
              onPressed: () {
                context.go(LimitedPageLayout.routeName + SignUpView.routeName);
              },
            )
          ]),
        ],
      ),
    );
  }
}
