import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/post_db.dart';

part 'post_db_provider.g.dart';

@Riverpod(keepAlive: true)
PostDB postDB(PostDBRef ref) {
  return PostDB(ref);
}
