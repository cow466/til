import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:til/features/crud_collection.dart';

part 'friend_request.freezed.dart';
part 'friend_request.g.dart';

@freezed
class FriendRequest with _$FriendRequest implements JsonConvertible {
  factory FriendRequest({
    required DocumentId id,
    required DocumentId from,
    required DocumentId to,
    required DateTime sentAt,
  }) = _FriendRequest;

  factory FriendRequest.fromJson(Map<String, Object?> json) =>
      _$FriendRequestFromJson(json);
}
