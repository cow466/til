// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserReport _$UserReportFromJson(Map<String, dynamic> json) {
  return _UserReport.fromJson(json);
}

/// @nodoc
mixin _$UserReport {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserReportCopyWith<UserReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserReportCopyWith<$Res> {
  factory $UserReportCopyWith(
          UserReport value, $Res Function(UserReport) then) =
      _$UserReportCopyWithImpl<$Res, UserReport>;
  @useResult
  $Res call({String id, String userId, String reason});
}

/// @nodoc
class _$UserReportCopyWithImpl<$Res, $Val extends UserReport>
    implements $UserReportCopyWith<$Res> {
  _$UserReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserReportImplCopyWith<$Res>
    implements $UserReportCopyWith<$Res> {
  factory _$$UserReportImplCopyWith(
          _$UserReportImpl value, $Res Function(_$UserReportImpl) then) =
      __$$UserReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String userId, String reason});
}

/// @nodoc
class __$$UserReportImplCopyWithImpl<$Res>
    extends _$UserReportCopyWithImpl<$Res, _$UserReportImpl>
    implements _$$UserReportImplCopyWith<$Res> {
  __$$UserReportImplCopyWithImpl(
      _$UserReportImpl _value, $Res Function(_$UserReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? reason = null,
  }) {
    return _then(_$UserReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserReportImpl with DiagnosticableTreeMixin implements _UserReport {
  _$UserReportImpl(
      {required this.id, required this.userId, required this.reason});

  factory _$UserReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserReportImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String reason;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserReport(id: $id, userId: $userId, reason: $reason)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserReport'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('reason', reason));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserReportImplCopyWith<_$UserReportImpl> get copyWith =>
      __$$UserReportImplCopyWithImpl<_$UserReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserReportImplToJson(
      this,
    );
  }
}

abstract class _UserReport implements UserReport {
  factory _UserReport(
      {required final String id,
      required final String userId,
      required final String reason}) = _$UserReportImpl;

  factory _UserReport.fromJson(Map<String, dynamic> json) =
      _$UserReportImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$UserReportImplCopyWith<_$UserReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
