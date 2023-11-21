import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/crud_collection.dart';
import '../domain/organization.dart';

final class OrganizationDB extends CrudCollection<Organization> {
  OrganizationDB(this.ref)
      : super(
          collectionPath: 'organizations',
          fromJson: Organization.fromJson,
        );

  final ProviderRef<OrganizationDB> ref;
  // final List<Organization> _organization = [
  //   Organization(
  //     id: '0',
  //     name: 'University of Hawaii at Manoa',
  //     website: 'https://manoa.hawaii.edu/',
  //     members: ['0', '1'],
  //   ),
  //   Organization(
  //     id: '1',
  //     name: 'University of Illinois Urbana-Champaign',
  //     website: 'https://illinois.edu/',
  //     members: ['2'],
  //   ),
  // ];
}
