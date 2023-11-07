import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'friend_request.freezed.dart';
part 'friend_request.g.dart';

@freezed
class FriendRequest with _$FriendRequest {
  factory FriendRequest({
    required String id,
    required String from,
    required String to,
    required DateTime sentAt,
  }) = _FriendRequest;

  factory FriendRequest.fromJson(Map<String, Object?> json) =>
      _$FriendRequestFromJson(json);
}
