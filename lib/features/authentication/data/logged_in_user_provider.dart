import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../user/domain/user_db.dart';
import '../../user/data/user_db_provider.dart';

part 'logged_in_user_provider.g.dart';

@riverpod
class LoggedInUserNotifier extends _$LoggedInUserNotifier {
  @override
  User? build() => null;

  Future<void> signInAs({
    required String email,
    required String password,
    required WidgetRef ref,
  }) async {
    var newUser = ref.watch(userDBProvider).signInAs(email);
    state = newUser;
  }

  Future<void> signOut() async {
    state = null;
  }
}