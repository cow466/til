class User {
  User({
    required this.id,
    required this.name,
    required this.organizationId,
    required this.email,
    required this.isVerified,
    required this.imagePath,
    required this.role,
    required this.friendIds,
  });

  String id;
  String name;
  String organizationId;
  String email;
  bool isVerified;
  String imagePath;
  Role role;
  List<String> friendIds;
}

enum Role {
  user,
  organization,
  admin,
}

class UserDB {
  final List<User> _users = [
    User(
      id: '0',
      name: 'John Foo',
      organizationId: '0',
      email: 'johnfoo@hawaii.edu',
      isVerified: false,
      imagePath: 'jenna-deane.jpg',
      role: Role.user,
      friendIds: [],
    ),
    User(
      id: '1',
      name: 'Winston Co',
      organizationId: '0',
      email: 'cow@hawaii.edu',
      isVerified: true,
      imagePath: 'winston_co.png',
      role: Role.user,
      friendIds: [],
    ),
    User(
      id: '2',
      name: 'Korn Jiamsripong',
      organizationId: '1',
      email: 'kornj2@illinois.edu',
      isVerified: true,
      imagePath: 'winston_co.png',
      role: Role.user,
      friendIds: [],
    ),
  ];

  User getById(String id) {
    return _users.firstWhere((user) => user.id == id);
  }

  List<User> getUsers(List<String> userIDs) {
    return _users.where((user) => userIDs.contains(user.id)).toList();
  }
}

UserDB userDB = UserDB();
