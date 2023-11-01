import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/organization_db.dart';

part 'organization_db_provider.g.dart';

@Riverpod(keepAlive: true)
OrganizationDB organizationDB(OrganizationDBRef ref) {
  return OrganizationDB(ref);
}
