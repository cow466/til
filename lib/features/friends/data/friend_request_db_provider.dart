import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/friend_request_db.dart';

part 'friend_request_db_provider.g.dart';

@Riverpod(keepAlive: true)
FriendRequestDB friendRequestDB(FriendRequestDBRef ref) {
  return FriendRequestDB(ref);
}
