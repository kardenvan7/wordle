import 'package:freezed_annotation/freezed_annotation.dart';

part 'validated_character.freezed.dart';

@freezed
class ValidatedCharacter with _$ValidatedCharacter {
  const ValidatedCharacter._();

  factory ValidatedCharacter({
    required String character,
    required int index,
    required ValidatedCharacterState state,
  }) = _ValidatedCharacter;
}

enum ValidatedCharacterState {
  notPresent,
  presentInOtherPosition,
  correct;
}
