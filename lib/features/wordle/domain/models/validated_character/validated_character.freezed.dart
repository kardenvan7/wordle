// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validated_character.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ValidatedCharacter {
  String get character => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  ValidatedCharacterState get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValidatedCharacterCopyWith<ValidatedCharacter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidatedCharacterCopyWith<$Res> {
  factory $ValidatedCharacterCopyWith(
          ValidatedCharacter value, $Res Function(ValidatedCharacter) then) =
      _$ValidatedCharacterCopyWithImpl<$Res, ValidatedCharacter>;
  @useResult
  $Res call({String character, int index, ValidatedCharacterState state});
}

/// @nodoc
class _$ValidatedCharacterCopyWithImpl<$Res, $Val extends ValidatedCharacter>
    implements $ValidatedCharacterCopyWith<$Res> {
  _$ValidatedCharacterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? character = null,
    Object? index = null,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ValidatedCharacterState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ValidatedCharacterCopyWith<$Res>
    implements $ValidatedCharacterCopyWith<$Res> {
  factory _$$_ValidatedCharacterCopyWith(_$_ValidatedCharacter value,
          $Res Function(_$_ValidatedCharacter) then) =
      __$$_ValidatedCharacterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String character, int index, ValidatedCharacterState state});
}

/// @nodoc
class __$$_ValidatedCharacterCopyWithImpl<$Res>
    extends _$ValidatedCharacterCopyWithImpl<$Res, _$_ValidatedCharacter>
    implements _$$_ValidatedCharacterCopyWith<$Res> {
  __$$_ValidatedCharacterCopyWithImpl(
      _$_ValidatedCharacter _value, $Res Function(_$_ValidatedCharacter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? character = null,
    Object? index = null,
    Object? state = null,
  }) {
    return _then(_$_ValidatedCharacter(
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ValidatedCharacterState,
    ));
  }
}

/// @nodoc

class _$_ValidatedCharacter extends _ValidatedCharacter {
  _$_ValidatedCharacter(
      {required this.character, required this.index, required this.state})
      : super._();

  @override
  final String character;
  @override
  final int index;
  @override
  final ValidatedCharacterState state;

  @override
  String toString() {
    return 'ValidatedCharacter(character: $character, index: $index, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ValidatedCharacter &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, character, index, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ValidatedCharacterCopyWith<_$_ValidatedCharacter> get copyWith =>
      __$$_ValidatedCharacterCopyWithImpl<_$_ValidatedCharacter>(
          this, _$identity);
}

abstract class _ValidatedCharacter extends ValidatedCharacter {
  factory _ValidatedCharacter(
      {required final String character,
      required final int index,
      required final ValidatedCharacterState state}) = _$_ValidatedCharacter;
  _ValidatedCharacter._() : super._();

  @override
  String get character;
  @override
  int get index;
  @override
  ValidatedCharacterState get state;
  @override
  @JsonKey(ignore: true)
  _$$_ValidatedCharacterCopyWith<_$_ValidatedCharacter> get copyWith =>
      throw _privateConstructorUsedError;
}
