class Organization {
  Organization({
    required this.id,
    required this.name,
    this.email = '',
    this.website = '',
    this.address = '',
    required this.members,
  });

  String id;
  String name;
  String email;
  String website;
  String address;
  List<String> members;
}

class OrganizationDB {
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

OrganizationDB organizationDB = OrganizationDB();
