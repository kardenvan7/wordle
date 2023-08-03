part of 'word_field.dart';

abstract interface class WordFieldController {
  factory WordFieldController({
    required String correctWord,
  }) = _UnsafeWordFieldController;

  WordFieldState get state;

  abstract final ValueListenable<WordFieldState> listenable;

  abstract final String correctWord;

  void addLetter(String letter);

  void eraseLetter();

  void validate();

  void clear();

  void dispose();
}

abstract class _WordFieldControllerImpl implements WordFieldController {
  _WordFieldControllerImpl._({
    required this.letterFieldControllers,
  }) : _valueNotifier = ValueNotifier(
          WordFieldState.initial(
            letterStates: letterFieldControllers
                .map((e) => e.state)
                .toList(growable: false),
          ),
        );

  final List<LetterFieldController> letterFieldControllers;
  final ValueNotifier<WordFieldState> _valueNotifier;

  @override
  WordFieldState get state => listenable.value;

  @override
  ValueListenable<WordFieldState> get listenable => _valueNotifier;

  @override
  void dispose() {
    _disposeControllers();
  }

  WordFieldState get _stateFromControllers {
    final List<LetterFieldState> letterStates = [];
    late final WordFieldValidationStatus wordFieldValidationStatus;

    bool hasIncorrectLetters = false;
    bool hasNotValidatedLetters = false;

    for (int i = letterFieldControllers.length - 1; i >= 0; i--) {
      final controller = letterFieldControllers[i];
      final letterState = controller.state;

      letterStates.insert(0, letterState);

      switch (letterState) {
        case EmptyLetterFieldState():
          hasNotValidatedLetters = true;
          break;
        case FilledLetterFieldState(validationStatus: final status):
          switch (status) {
            case LetterValidationStatus.notValidated:
              hasNotValidatedLetters = true;
              break;
            case LetterValidationStatus.absent:
              hasIncorrectLetters = true;
              break;
            case LetterValidationStatus.wrongPlacement:
              hasIncorrectLetters = true;
              break;
            case LetterValidationStatus.correct:
              break;
          }
      }
    }

    if (hasNotValidatedLetters) {
      wordFieldValidationStatus = WordFieldValidationStatus.notValidated;
    } else {
      if (hasIncorrectLetters) {
        wordFieldValidationStatus = WordFieldValidationStatus.incorrect;
      } else {
        wordFieldValidationStatus = WordFieldValidationStatus.correct;
      }
    }

    return WordFieldState(
      letterStates: letterStates,
      validationStatus: wordFieldValidationStatus,
    );
  }

  LetterFieldController? get _firstEmptyLetterController =>
      letterFieldControllers.firstWhereOrNull(
        (element) => element.state is EmptyLetterFieldState,
      );

  LetterFieldController? get _lastNonEmptyLetterController {
    for (int i = letterFieldControllers.length - 1; i >= 0; i--) {
      final controller = letterFieldControllers[i];

      if (controller.state is FilledLetterFieldState) return controller;
    }

    return null;
  }

  bool get _isValidated =>
      state.validationStatus != WordFieldValidationStatus.notValidated;

  bool get _hasEmptyLetterFields {
    for (int i = letterFieldControllers.length - 1; i >= 0; i--) {
      final currentState = letterFieldControllers[i].state;

      if (currentState is EmptyLetterFieldState) return true;
    }

    return false;
  }

  void _setStateFromControllers() {
    _valueNotifier.value = _stateFromControllers;
  }

  void _disposeControllers() {
    for (final letterController in letterFieldControllers) {
      letterController.dispose();
    }
  }
}

class _UnsafeWordFieldController extends _WordFieldControllerImpl {
  _UnsafeWordFieldController({
    required this.correctWord,
  }) : super._(
          letterFieldControllers: List.generate(
            correctWord.length,
            (index) => LetterFieldController(),
          ),
        );

  @override
  final String correctWord;

  @override
  void addLetter(String letter) {
    if (_isValidated) {
      throw Exception('Can not add a letter to already validated word field');
    }

    final controller = _firstEmptyLetterController;

    if (controller == null) {
      throw Exception('Can not add a letter to fully filled word field');
    }

    controller.setLetter(letter);

    _setStateFromControllers();
  }

  @override
  void eraseLetter() {
    if (_isValidated) {
      throw Exception('Can not erase letter in validated word');
    }

    final controller = _lastNonEmptyLetterController;

    if (controller == null) {
      throw Exception('Can not erase letter in empty word field');
    }

    controller.eraseLetter();

    _setStateFromControllers();
  }

  @override
  void validate() {
    if (_isValidated) {
      throw Exception('Can not validate already validated word field');
    }

    if (_hasEmptyLetterFields) {
      throw Exception('Can not validate word field with empty letter fields');
    }

    _validateLetters();

    _setStateFromControllers();
  }

  @override
  void clear() {
    for (final controller in letterFieldControllers) {
      controller.clear();
    }

    _setStateFromControllers();
  }

  void _validateLetters() {
    for (int i = 0; i < letterFieldControllers.length; i++) {
      final controller = letterFieldControllers[i];
      final status = _validateLetter(controller, correctWord[i]);

      controller.setValidationStatus(status);
    }
  }

  LetterValidationStatus _validateLetter(
    LetterFieldController controller,
    String correctLetter,
  ) {
    switch (controller.state) {
      case EmptyLetterFieldState():
        throw Exception('Can not validate empty letter field');
      case FilledLetterFieldState(letter: final letter):
        if (letter == correctLetter) {
          return LetterValidationStatus.correct;
        } else {
          if (correctWord.contains(letter)) {
            return LetterValidationStatus.wrongPlacement;
          } else {
            return LetterValidationStatus.absent;
          }
        }
    }
  }
}
