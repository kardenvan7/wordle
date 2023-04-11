import 'package:wordle/features/wordle/domain/services/word_validator_service.dart';

class WordleGame {
  WordleGame({
    required this.attemptsCount,
    required this.word,
    required WordValidationService validationService,
  }) : _validator = validationService;

  final WordValidationService _validator;
  final int attemptsCount;
  final String word;

  int _previousAttemptsCount = 0;

  bool get _hasAttempts => _previousAttemptsCount < attemptsCount;

  Future<AttemptWordResult> attemptWord(String guessWord) async {
    if (!_hasAttempts) {
      return const AttemptWordResult.noAttemptsLeft();
    }

    final validationResult = await _validator.validate(
      guessWord,
      word,
    );

    return validationResult.fold<AttemptWordResult>(
      onFailure: _onWordValidationFailure,
      onSuccess: _onWordValidationSuccess,
    );
  }

  AttemptWordResult _onWordValidationFailure(WordValidationFailure failure) {
    return AttemptWordResult.invalid(failure);
  }

  AttemptWordResult _onWordValidationSuccess(
    List<ValidatedCharacter> validatedChars,
  ) {
    _incrementPreviousAttemptsCount();

    if (_isWordCorrect(validatedChars)) {
      return AttemptWordResult.correct(_previousAttemptsCount);
    } else {
      return AttemptWordResult.incorrect(validatedChars);
    }
  }

  bool _isWordCorrect(List<ValidatedCharacter> characters) {
    return characters.every(
      (element) => element.state == ValidatedCharacterState.correct,
    );
  }

  void _incrementPreviousAttemptsCount() {
    _previousAttemptsCount++;
  }
}

class AttemptWordResult with _$AttemptWordResult {
  const AttemptWordResult._();

  const factory AttemptWordResult.invalid(
    WordValidationFailure failure,
  ) = _InvalidAttemptWordResult;

  const factory AttemptWordResult.incorrect(
    List<ValidatedCharacter> validatedCharacters,
  ) = _IncorrectAttemtpWordResult;

  const factory AttemptWordResult.correct(
    int attemptNumber,
  ) = _CorrectAttemptWordResult;

  const factory AttemptWordResult.noAttemptsLeft() =
      _NoAttemptsLeftAttemptWordResult;
}
