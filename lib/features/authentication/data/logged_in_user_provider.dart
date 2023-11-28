import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/authentication/data/auth_controller_provider.dart';
import 'package:til/features/firebase/data/firebase_auth_provider.dart';
import '../../user/domain/user.dart';
import '../../user/data/user_db_provider.dart';

part 'logged_in_user_provider.g.dart';

@riverpod
Future<User?> loggedInUser(LoggedInUserRef ref) async {
  ref.watch(authControllerProvider);
  final uid = ref.watch(authStateChangesProvider).valueOrNull?.uid;
  if (uid == null) {
    return null;
  }
  var userDB = ref.watch(userDBProvider);
  var userDoc = await userDB.getWhere('userUid', isEqualTo: uid);
  if (userDoc.isEmpty) {
    return null;
  }
  if (userDoc.length > 1) {
    throw Exception(
      'Error in `users` collection: Multiple documents associated with uid: $uid',
    );
  }

  return userDoc[0];
}
