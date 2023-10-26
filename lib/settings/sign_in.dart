import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:til/data/user_db.dart';

User? _loggedInUser;

Future<void> signInAs({
  required String email,
  required String password,
  required WidgetRef ref,
}) async {
  var newUser = ref.watch(userDBProvider).signInAs(email);
  _loggedInUser = newUser;
}

final loggedInUserProvider = Provider((ref) {
  return _loggedInUser;
});
