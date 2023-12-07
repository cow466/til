// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationImpl _$$OrganizationImplFromJson(Map<String, dynamic> json) =>
    _$OrganizationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String? ?? '',
      website: json['website'] as String? ?? '',
      address: json['address'] as String? ?? '',
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      admins:
          (json['admins'] as List<dynamic>).map((e) => e as String).toList(),
      bannerImage:
          json['bannerImage'] as String? ?? 'assets/images/uhm-banner.jpg',
      logoImage: json['logoImage'] as String? ?? 'assets/images/uhm-logo.png',
    );

Map<String, dynamic> _$$OrganizationImplToJson(_$OrganizationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'website': instance.website,
      'address': instance.address,
      'members': instance.members,
      'admins': instance.admins,
      'bannerImage': instance.bannerImage,
      'logoImage': instance.logoImage,
    };
