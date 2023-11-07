import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/organization.dart';

class OrganizationDB {
  OrganizationDB(this.ref);

  final ProviderRef<OrganizationDB> ref;
  final List<Organization> _organization = [
    Organization(
      id: '0',
      name: 'University of Hawaii at Manoa',
      website: 'https://manoa.hawaii.edu/',
      members: ['0', '1'],
    ),
    Organization(
      id: '1',
      name: 'University of Illinois Urbana-Champaign',
      website: 'https://illinois.edu/',
      members: ['2'],
    ),
  ];

  Organization getById(String id) {
    return _organization.firstWhere((org) => org.id == id);
  }
}
