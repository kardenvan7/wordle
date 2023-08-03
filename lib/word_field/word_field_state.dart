part of 'word_field.dart';

class WordFieldState {
  const WordFieldState({
    required this.letterStates,
    required this.validationStatus,
  });

  factory WordFieldState.initial({
    required List<LetterFieldState> letterStates,
  }) {
    return WordFieldState(
      letterStates: letterStates,
      validationStatus: WordFieldValidationStatus.notValidated,
    );
  }

  final List<LetterFieldState> letterStates;
  final WordFieldValidationStatus validationStatus;

  @override
  int get hashCode => letterStates.hashCode ^ validationStatus.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! WordFieldState) return false;

    return validationStatus == other.validationStatus &&
        letterStates.equals(other.letterStates);
  }

  @override
  String toString() {
    return '$runtimeType('
        'letterStates: $letterStates, '
        'validationStatus: $validationStatus'
        ')';
  }
}

enum WordFieldValidationStatus {
  notValidated,
  incorrect,
  correct,
}
