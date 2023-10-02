part of 'letter_field.dart';

sealed class LetterFieldState {}

final class EmptyLetterFieldState implements LetterFieldState {
  const EmptyLetterFieldState();

  @override
  bool operator ==(Object other) {
    return other is EmptyLetterFieldState;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class FilledLetterFieldState implements LetterFieldState {
  const FilledLetterFieldState({
    required this.letter,
    required this.validationStatus,
  }) : assert(letter.length == 1);

  final String letter;
  final LetterValidationStatus validationStatus;

  @override
  int get hashCode => Object.hash(letter, validationStatus);

  @override
  bool operator ==(Object other) {
    if (other is! FilledLetterFieldState) return false;

    return letter == other.letter && validationStatus == other.validationStatus;
  }

  @override
  String toString() {
    return '$runtimeType('
        'letter: $letter, '
        'status: $validationStatus'
        ')';
  }
}

enum LetterValidationStatus {
  notValidated,
  absent,
  wrongPlacement,
  correct,
}
