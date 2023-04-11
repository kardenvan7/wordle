// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserStatistics {
  int get maxStreak => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  Map<int, int> get winsCountByAttemptNumber =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserStatisticsCopyWith<UserStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatisticsCopyWith<$Res> {
  factory $UserStatisticsCopyWith(
          UserStatistics value, $Res Function(UserStatistics) then) =
      _$UserStatisticsCopyWithImpl<$Res, UserStatistics>;
  @useResult
  $Res call(
      {int maxStreak,
      int currentStreak,
      Map<int, int> winsCountByAttemptNumber});
}

/// @nodoc
class _$UserStatisticsCopyWithImpl<$Res, $Val extends UserStatistics>
    implements $UserStatisticsCopyWith<$Res> {
  _$UserStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxStreak = null,
    Object? currentStreak = null,
    Object? winsCountByAttemptNumber = null,
  }) {
    return _then(_value.copyWith(
      maxStreak: null == maxStreak
          ? _value.maxStreak
          : maxStreak // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      winsCountByAttemptNumber: null == winsCountByAttemptNumber
          ? _value.winsCountByAttemptNumber
          : winsCountByAttemptNumber // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserStatisticsCopyWith<$Res>
    implements $UserStatisticsCopyWith<$Res> {
  factory _$$_UserStatisticsCopyWith(
          _$_UserStatistics value, $Res Function(_$_UserStatistics) then) =
      __$$_UserStatisticsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int maxStreak,
      int currentStreak,
      Map<int, int> winsCountByAttemptNumber});
}

/// @nodoc
class __$$_UserStatisticsCopyWithImpl<$Res>
    extends _$UserStatisticsCopyWithImpl<$Res, _$_UserStatistics>
    implements _$$_UserStatisticsCopyWith<$Res> {
  __$$_UserStatisticsCopyWithImpl(
      _$_UserStatistics _value, $Res Function(_$_UserStatistics) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxStreak = null,
    Object? currentStreak = null,
    Object? winsCountByAttemptNumber = null,
  }) {
    return _then(_$_UserStatistics(
      maxStreak: null == maxStreak
          ? _value.maxStreak
          : maxStreak // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      winsCountByAttemptNumber: null == winsCountByAttemptNumber
          ? _value._winsCountByAttemptNumber
          : winsCountByAttemptNumber // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
    ));
  }
}

/// @nodoc

class _$_UserStatistics extends _UserStatistics {
  const _$_UserStatistics(
      {required this.maxStreak,
      required this.currentStreak,
      required final Map<int, int> winsCountByAttemptNumber})
      : _winsCountByAttemptNumber = winsCountByAttemptNumber,
        super._();

  @override
  final int maxStreak;
  @override
  final int currentStreak;
  final Map<int, int> _winsCountByAttemptNumber;
  @override
  Map<int, int> get winsCountByAttemptNumber {
    if (_winsCountByAttemptNumber is EqualUnmodifiableMapView)
      return _winsCountByAttemptNumber;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_winsCountByAttemptNumber);
  }

  @override
  String toString() {
    return 'UserStatistics(maxStreak: $maxStreak, currentStreak: $currentStreak, winsCountByAttemptNumber: $winsCountByAttemptNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserStatistics &&
            (identical(other.maxStreak, maxStreak) ||
                other.maxStreak == maxStreak) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            const DeepCollectionEquality().equals(
                other._winsCountByAttemptNumber, _winsCountByAttemptNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, maxStreak, currentStreak,
      const DeepCollectionEquality().hash(_winsCountByAttemptNumber));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserStatisticsCopyWith<_$_UserStatistics> get copyWith =>
      __$$_UserStatisticsCopyWithImpl<_$_UserStatistics>(this, _$identity);
}

abstract class _UserStatistics extends UserStatistics {
  const factory _UserStatistics(
          {required final int maxStreak,
          required final int currentStreak,
          required final Map<int, int> winsCountByAttemptNumber}) =
      _$_UserStatistics;
  const _UserStatistics._() : super._();

  @override
  int get maxStreak;
  @override
  int get currentStreak;
  @override
  Map<int, int> get winsCountByAttemptNumber;
  @override
  @JsonKey(ignore: true)
  _$$_UserStatisticsCopyWith<_$_UserStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}
