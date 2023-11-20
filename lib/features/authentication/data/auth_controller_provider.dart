// https://codewithandrea.com/articles/flutter-riverpod-async-notifier/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/authentication/data/firebase_auth_provider.dart';
import 'package:til/features/user/data/user_db_provider.dart';

part 'auth_controller_provider.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> signInAs({
    required String name,
    required String email,
    required String aboutMe,
    required WidgetRef ref,
  }) async {
    state = const AsyncValue.loading();
    final uid = ref.watch(firebaseAuthProvider).currentUser?.uid;
    if (uid == null) {
      return;
    }
    final userDB = ref.watch(userDBProvider);
    state = await AsyncValue.guard(() async {
      userDB.createUser(
        userUid: uid,
        name: name,
        email: email,
        aboutMe: aboutMe,
      );
      final userDoc = await userDB.getWhere('userUid', isEqualTo: uid);
      if (userDoc.isEmpty) {
        return;
      }
      if (userDoc.length > 1) {
        throw Exception(
          'Error in `users` collection: Multiple documents associated with uid: $uid',
        );
      }
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.watch(firebaseAuthProvider).signOut();
    });
  }
}
