// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendRequestImpl _$$FriendRequestImplFromJson(Map<String, dynamic> json) =>
    _$FriendRequestImpl(
      id: json['id'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
    );

Map<String, dynamic> _$$FriendRequestImplToJson(_$FriendRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from': instance.from,
      'to': instance.to,
      'sentAt': instance.sentAt.toIso8601String(),
    };
