import 'package:til/data/user_db.dart';

User? loggedInUser;

Future<void> signInAs({
  required String email,
  required String password,
}) async {
  var newUser = userDB.getById('1');
  loggedInUser = newUser;
}
