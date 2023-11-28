// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      userUid: json['userUid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      organizationId: json['organizationId'] as String,
      aboutMe: json['aboutMe'] as String,
      isVerified: json['isVerified'] as bool,
      imagePath: json['imagePath'] as String,
      role: $enumDecode(_$RoleEnumMap, json['role']),
      friendIds:
          (json['friendIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userUid': instance.userUid,
      'name': instance.name,
      'email': instance.email,
      'organizationId': instance.organizationId,
      'aboutMe': instance.aboutMe,
      'isVerified': instance.isVerified,
      'imagePath': instance.imagePath,
      'role': _$RoleEnumMap[instance.role]!,
      'friendIds': instance.friendIds,
    };

const _$RoleEnumMap = {
  Role.user: 'user',
  Role.organizationAdmin: 'organizationAdmin',
  Role.admin: 'admin',
};
