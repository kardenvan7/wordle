// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wordle_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WordleType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() daily,
    required TResult Function(int wordLength) random,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? daily,
    TResult? Function(int wordLength)? random,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? daily,
    TResult Function(int wordLength)? random,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_$DailyWordleType value) daily,
    required TResult Function(_$RandomWordleType value) random,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_$DailyWordleType value)? daily,
    TResult? Function(_$RandomWordleType value)? random,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_$DailyWordleType value)? daily,
    TResult Function(_$RandomWordleType value)? random,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordleTypeCopyWith<$Res> {
  factory $WordleTypeCopyWith(
          WordleType value, $Res Function(WordleType) then) =
      _$WordleTypeCopyWithImpl<$Res, WordleType>;
}

/// @nodoc
class _$WordleTypeCopyWithImpl<$Res, $Val extends WordleType>
    implements $WordleTypeCopyWith<$Res> {
  _$WordleTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_$DailyWordleTypeCopyWith<$Res> {
  factory _$$_$DailyWordleTypeCopyWith(
          _$_$DailyWordleType value, $Res Function(_$_$DailyWordleType) then) =
      __$$_$DailyWordleTypeCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_$DailyWordleTypeCopyWithImpl<$Res>
    extends _$WordleTypeCopyWithImpl<$Res, _$_$DailyWordleType>
    implements _$$_$DailyWordleTypeCopyWith<$Res> {
  __$$_$DailyWordleTypeCopyWithImpl(
      _$_$DailyWordleType _value, $Res Function(_$_$DailyWordleType) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_$DailyWordleType extends _$DailyWordleType {
  const _$_$DailyWordleType() : super._();

  @override
  String toString() {
    return 'WordleType.daily()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_$DailyWordleType);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() daily,
    required TResult Function(int wordLength) random,
  }) {
    return daily();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? daily,
    TResult? Function(int wordLength)? random,
  }) {
    return daily?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? daily,
    TResult Function(int wordLength)? random,
    required TResult orElse(),
  }) {
    if (daily != null) {
      return daily();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_$DailyWordleType value) daily,
    required TResult Function(_$RandomWordleType value) random,
  }) {
    return daily(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_$DailyWordleType value)? daily,
    TResult? Function(_$RandomWordleType value)? random,
  }) {
    return daily?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_$DailyWordleType value)? daily,
    TResult Function(_$RandomWordleType value)? random,
    required TResult orElse(),
  }) {
    if (daily != null) {
      return daily(this);
    }
    return orElse();
  }
}

abstract class _$DailyWordleType extends WordleType {
  const factory _$DailyWordleType() = _$_$DailyWordleType;
  const _$DailyWordleType._() : super._();
}

/// @nodoc
abstract class _$$_$RandomWordleTypeCopyWith<$Res> {
  factory _$$_$RandomWordleTypeCopyWith(_$_$RandomWordleType value,
          $Res Function(_$_$RandomWordleType) then) =
      __$$_$RandomWordleTypeCopyWithImpl<$Res>;
  @useResult
  $Res call({int wordLength});
}

/// @nodoc
class __$$_$RandomWordleTypeCopyWithImpl<$Res>
    extends _$WordleTypeCopyWithImpl<$Res, _$_$RandomWordleType>
    implements _$$_$RandomWordleTypeCopyWith<$Res> {
  __$$_$RandomWordleTypeCopyWithImpl(
      _$_$RandomWordleType _value, $Res Function(_$_$RandomWordleType) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordLength = null,
  }) {
    return _then(_$_$RandomWordleType(
      wordLength: null == wordLength
          ? _value.wordLength
          : wordLength // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_$RandomWordleType extends _$RandomWordleType {
  const _$_$RandomWordleType({required this.wordLength}) : super._();

  @override
  final int wordLength;

  @override
  String toString() {
    return 'WordleType.random(wordLength: $wordLength)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_$RandomWordleType &&
            (identical(other.wordLength, wordLength) ||
                other.wordLength == wordLength));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wordLength);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_$RandomWordleTypeCopyWith<_$_$RandomWordleType> get copyWith =>
      __$$_$RandomWordleTypeCopyWithImpl<_$_$RandomWordleType>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() daily,
    required TResult Function(int wordLength) random,
  }) {
    return random(wordLength);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? daily,
    TResult? Function(int wordLength)? random,
  }) {
    return random?.call(wordLength);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? daily,
    TResult Function(int wordLength)? random,
    required TResult orElse(),
  }) {
    if (random != null) {
      return random(wordLength);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_$DailyWordleType value) daily,
    required TResult Function(_$RandomWordleType value) random,
  }) {
    return random(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_$DailyWordleType value)? daily,
    TResult? Function(_$RandomWordleType value)? random,
  }) {
    return random?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_$DailyWordleType value)? daily,
    TResult Function(_$RandomWordleType value)? random,
    required TResult orElse(),
  }) {
    if (random != null) {
      return random(this);
    }
    return orElse();
  }
}

abstract class _$RandomWordleType extends WordleType {
  const factory _$RandomWordleType({required final int wordLength}) =
      _$_$RandomWordleType;
  const _$RandomWordleType._() : super._();

  int get wordLength;
  @JsonKey(ignore: true)
  _$$_$RandomWordleTypeCopyWith<_$_$RandomWordleType> get copyWith =>
      throw _privateConstructorUsedError;
}
