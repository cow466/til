import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_report.freezed.dart';
part 'user_report.g.dart';

@freezed
class UserReport with _$UserReport {
  factory UserReport({
    required String id,
    required String userId,
    required String reason,
  }) = _UserReport;

  factory UserReport.fromJson(Map<String, Object?> json) =>
      _$UserReportFromJson(json);
}
