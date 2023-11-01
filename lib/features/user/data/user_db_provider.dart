import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/user_db.dart';

part 'user_db_provider.g.dart';

@Riverpod(keepAlive: true)
UserDB userDB(UserDBRef ref) {
  return UserDB(ref);
}
