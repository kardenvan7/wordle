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

  factory WordFieldState.empty(int letterCount) {
    return WordFieldState(
      letterStates: List.generate(
        letterCount,
        (index) => const EmptyLetterFieldState(),
      ),
      validationStatus: WordFieldValidationStatus.notValidated,
    );
  }

  bool get isValidated =>
      validationStatus != WordFieldValidationStatus.notValidated;

  bool get isFilled {
    for (int i = letterStates.length - 1; i >= 0; i--) {
      if (letterStates[i] is EmptyLetterFieldState) return false;
    }

    return true;
  }

  bool get hasEmptyLetterFields {
    for (int i = letterStates.length - 1; i >= 0; i--) {
      final currentState = letterStates[i];

      if (currentState is EmptyLetterFieldState) return true;
    }

    return false;
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
