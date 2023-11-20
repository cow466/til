import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:til/features/crud_collection.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User implements JsonConvertible {
  factory User({
    required String id,
    required String userUid,
    required String name,
    required String email,
    required String organizationId,
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
