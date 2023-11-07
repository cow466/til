import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String id,
    required String name,
    required String organizationId,
    required String email,
    required String aboutMe,
    required bool isVerified,
    required String imagePath,
    required Role role,
    required List<String> friendIds,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

enum Role {
  user,
  organization,
  admin,
}
