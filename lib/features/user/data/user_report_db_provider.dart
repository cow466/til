import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/user_report_db.dart';

part 'user_report_db_provider.g.dart';

@Riverpod(keepAlive: true)
UserReportDB userReportDB(UserReportDBRef ref) {
  return UserReportDB(ref);
}
