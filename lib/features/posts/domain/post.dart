import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:til/features/crud_collection.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post implements JsonConvertible {
  factory Post({
    required String userId,
    required String content,
    required DateTime postedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
