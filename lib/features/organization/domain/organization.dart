import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:til/features/crud_collection.dart';

part 'organization.freezed.dart';
part 'organization.g.dart';

@freezed
class Organization with _$Organization implements JsonConvertible {
  factory Organization({
    required String id,
    required String name,
    @Default('') String email,
    @Default('') String website,
    @Default('') String address,
    required List<String> members,
  }) = _Organization;

  factory Organization.fromJson(Map<String, Object?> json) =>
      _$OrganizationFromJson(json);
}
