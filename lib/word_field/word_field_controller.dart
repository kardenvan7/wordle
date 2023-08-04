part of 'word_field.dart';

abstract interface class WordFieldController {
  factory WordFieldController({
    required String correctWord,
    bool safeMode = false,
  }) {
    return _WordFieldControllerImpl(
      correctWord: correctWord,
      safeMode: safeMode,
    );
  }

  WordFieldState get state;

  abstract final ValueListenable<WordFieldState> listenable;

  abstract final String correctWord;

  bool get isFilled;

  bool get isValidated;

  void addLetter(String letter);

  void eraseLetter();

  void validate();

  void clear();

  void dispose();
}

class _WordFieldControllerImpl
    with SafeModeMixin
    implements WordFieldController {
  _WordFieldControllerImpl({
    required this.correctWord,
    required this.safeMode,
  }) : letterFieldControllers = List.generate(
          correctWord.length,
          (index) => LetterFieldController(),
        ) {
    _valueNotifier = ValueNotifier(
      WordFieldState.initial(
        letterStates: letterFieldControllers.map((e) => e.state).toList(),
      ),
    );
  }

  @override
  final String correctWord;
  @override
  final bool safeMode;

  final List<LetterFieldController> letterFieldControllers;
  late final ValueNotifier<WordFieldState> _valueNotifier;

  @override
  WordFieldState get state => listenable.value;

  @override
  ValueListenable<WordFieldState> get listenable => _valueNotifier;

  @override
  bool get isFilled {
    final letterStates = state.letterStates;

    for (int i = letterStates.length - 1; i >= 0; i--) {
      if (letterStates[i] is EmptyLetterFieldState) return false;
    }

    return true;
  }

  @override
  bool get isValidated =>
      state.validationStatus != WordFieldValidationStatus.notValidated;

  @override
  void addLetter(String letter) {
    if (_isValidated) {
      return handleError(
        'Can not add a letter to already validated word field',
      );
    }

    final controller = _firstEmptyLetterController;

    if (controller == null) {
      return handleError(
        'Can not add a letter to fully filled word field',
      );
    }

    controller.setLetter(letter);
    _setStateFromControllers();
  }

  @override
  void eraseLetter() {
    if (_isValidated) {
      return handleError(
        'Can not erase letter in validated word',
      );
    }

    final controller = _lastNonEmptyLetterController;

    if (controller == null) {
      return handleError(
        'Can not erase letter in empty word field',
      );
    }

    controller.eraseLetter();
    _setStateFromControllers();
  }

  @override
  void validate() {
    if (_isValidated) {
      return handleError('Can not validate already validated word field');
    }

    if (_hasEmptyLetterFields) {
      return handleError(
        'Can not validate word field with empty letter fields',
      );
    }

    _validateLetters();
    _setStateFromControllers();
  }

  @override
  void dispose() {
    _disposeControllers();
  }

  @override
  void clear() {
    _clearAllLetters();
    _setStateFromControllers();
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

  void _clearAllLetters() {
    for (final controller in letterFieldControllers) {
      controller.clear();
    }
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
        if (safeMode) LetterValidationStatus.notValidated;
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

  void _disposeControllers() {
    for (final letterController in letterFieldControllers) {
      letterController.dispose();
    }
  }
}
