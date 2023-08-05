part of 'letter_field.dart';

typedef TriggerShakeCallback = void Function(LetterFieldShakeType type);

abstract interface class LetterFieldShaker {
  void shake(TriggerShakeCallback shake);
}

class DefaultLetterFieldShaker implements LetterFieldShaker {
  const DefaultLetterFieldShaker();

  @override
  void shake(TriggerShakeCallback triggerShake) {
    triggerShake(const DefaultLetterFieldShakeType());
  }
}

sealed class LetterFieldShakeType {}

class DefaultLetterFieldShakeType implements LetterFieldShakeType {
  const DefaultLetterFieldShakeType();
}
