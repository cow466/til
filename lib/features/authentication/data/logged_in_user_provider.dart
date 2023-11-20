import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/authentication/data/firebase_auth_provider.dart';
import '../../user/domain/user.dart';
import '../../user/data/user_db_provider.dart';

part 'logged_in_user_provider.g.dart';

Future<void> signInAs({
  required String name,
  required String email,
  required String aboutMe,
  required WidgetRef ref,
}) async {
  var uid = ref.watch(firebaseAuthProvider).currentUser?.uid;
  if (uid == null) {
    return;
  }
  final userDB = ref.watch(userDBProvider);
  userDB.createUser(
    userUid: uid,
    name: name,
    email: email,
    aboutMe: aboutMe,
  );
}

@riverpod
Future<User?> loggedInUser(LoggedInUserRef ref) async {
  final uid = ref.watch(authStateChangesProvider).valueOrNull?.uid;
  if (uid == null) {
    return null;
  }
  var userDB = ref.watch(userDBProvider);
  var userDoc = await userDB.getWhere('userUid', isEqualTo: uid);
  if (userDoc.isEmpty) {
    throw Exception(
      'Error in `users` collection: No documents associated with uid: $uid',
    );
  }
  if (userDoc.length > 1) {
    throw Exception(
      'Error in `users` collection: Multiple documents associated with uid: $uid',
    );
  }

  return userDoc[0];
}
