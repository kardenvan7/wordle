part of 'word_field.dart';

abstract interface class WordFieldValidator {
  void validate(
    List<LetterFieldController> letterFieldsControllers,
    WordFieldState state,
    String correctWord,
    VoidCallback updateState,
  );
}

class DefaultWordFieldValidator
    with ErrorHandlerMixin
    implements WordFieldValidator {
  const DefaultWordFieldValidator(this.safeMode);

  @override
  final bool safeMode;

  @override
  void validate(
    List<LetterFieldController> letterFieldsControllers,
    WordFieldState state,
    String correctWord,
    VoidCallback updateState,
  ) {
    if (state.isValidated) {
      return handleError('Can not validate already validated word field');
    }

    if (state.hasEmptyLetterFields) {
      return handleError(
        'Can not validate word field with empty letter fields',
      );
    }

    _validateLetters(letterFieldsControllers, correctWord);
    updateState();
  }

  void _validateLetters(
    List<LetterFieldController> letterFieldsControllers,
    String correctWord,
  ) {
    for (int i = 0; i < letterFieldsControllers.length; i++) {
      final controller = letterFieldsControllers[i];
      final status = _validateLetter(controller.state, correctWord, i);

      controller.setValidationStatus(status);
    }
  }

  LetterValidationStatus _validateLetter(
    LetterFieldState letterState,
    String correctWord,
    int letterIndex,
  ) {
    final formattedWord = _refineString(correctWord);
    final formattedCorrectLetter = _refineString(correctWord[letterIndex]);

    switch (letterState) {
      case EmptyLetterFieldState():
        if (safeMode) LetterValidationStatus.notValidated;
        throw Exception('Can not validate empty letter field');
      case FilledLetterFieldState(letter: final letter):
        final formattedLetter = _refineString(letter);

        if (formattedLetter == formattedCorrectLetter) {
          return LetterValidationStatus.correct;
        } else {
          if (formattedWord.contains(formattedLetter)) {
            return LetterValidationStatus.wrongPlacement;
          } else {
            return LetterValidationStatus.absent;
          }
        }
    }
  }

  String _refineString(String string) {
    return string.toLowerCase();
  }
}
