import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:til/features/crud_collection.dart';

part 'user_report.freezed.dart';
part 'user_report.g.dart';

@freezed
class UserReport with _$UserReport {
  factory UserReport({
    required DocumentId id,
    required DocumentId userId,
    required String reason,
  }) = _UserReport;

  factory UserReport.fromJson(Map<String, Object?> json) =>
      _$UserReportFromJson(json);
}
