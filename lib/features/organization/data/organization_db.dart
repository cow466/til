import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:til/features/crud_collection.dart';
import 'package:til/features/posts/data/post_db_provider.dart';
import 'package:til/features/posts/domain/post.dart';
import 'package:til/features/user/data/user_db_provider.dart';
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

  Future<List<Post>?> getMemberPosts(DocumentId id) async {
    final org = await getById(id);
    if (org == null) {
      return null;
    }
    return ref.watch(postDBProvider).getWhere('id', whereIn: org.members);
  }

  Future<DocumentId?> createOrganization({
    required UserUid adminUserUid,
    required String name,
    String? email,
    String? website,
    String? address,
    required String bannerImage,
    required String logoImage,
  }) async {
    final newOrganizationId = await createOne(Organization(
      id: '',
      name: name,
      admins: [adminUserUid],
      members: List.empty(),
      website: website ?? '',
      address: address ?? '',
      email: email ?? '',
      bannerImage: bannerImage,
      logoImage: logoImage,
    ));
    return newOrganizationId;
  }

  /// Returns the id of the new admin user
  Future<DocumentId?> createOrganizationAndAdmin({
    required UserUid adminUserUid,
    required String name,
    String? email,
    String? website,
    String? address,
    required String bannerImage,
    required String logoImage,
    required String accountName,
    required String accountEmail,
    required String accountImagePath,
    String? accountAboutMe,
  }) async {
    final orgId = await createOrganization(
      adminUserUid: adminUserUid,
      name: name,
      email: email,
      website: website,
      address: address,
      bannerImage: bannerImage,
      logoImage: logoImage,
    );
    if (orgId == null) {
      return null;
    }
    return ref.watch(userDBProvider).createOrganizationAdmin(
          userUid: adminUserUid,
          name: accountName,
          aboutMe: accountAboutMe,
          email: accountEmail,
          organizationId: orgId,
          imagePath: accountImagePath,
        );
  }
}
