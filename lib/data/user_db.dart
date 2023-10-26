import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_db.g.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.organizationId,
    required this.email,
    required this.aboutMe,
    required this.isVerified,
    required this.imagePath,
    required this.role,
    required this.friendIds,
  });

  String id;
  String name;
  String organizationId;
  String email;
  String aboutMe;
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
  UserDB(this.ref);

  final ProviderRef<UserDB> ref;
  final List<User> _users = [
    User(
      id: '0',
      name: 'John Foo',
      organizationId: '0',
      email: 'johnfoo@hawaii.edu',
      aboutMe: "I'm not a real person.",
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
      aboutMe: 'I kinda like algorithms.',
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
      aboutMe: "Hi. I don't like C++.",
      isVerified: true,
      imagePath: 'korn_jiamsripong.png',
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

  bool isUserEmail(String email) {
    return _users.any((user) => user.email == email);
  }

  User signInAs(String email) {
    return _users.firstWhere((user) => user.email == email);
  }
}

@riverpod
UserDB userDB(UserDBRef ref) {
  return UserDB(ref);
}
