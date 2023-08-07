part of 'word_field.dart';

abstract interface class WordFieldController implements Listenable {
  factory WordFieldController({
    required String correctWord,
    bool safeMode = false,
    WordFieldValidator? validator,
    WordFieldWriter? writer,
    WordFieldEraser? eraser,
    WordFieldShaker? shaker,
  }) {
    return _WordFieldControllerImpl(
      correctWord: correctWord,
      safeMode: safeMode,
      validator: validator,
      eraser: eraser,
      writer: writer,
      shaker: shaker,
    );
  }

  WordFieldState get state;

  String get correctWord;

  void addLetter(String letter);

  void eraseLetter();

  void validate();

  void shake();

  void clear();

  void dispose();
}

final class _WordFieldControllerImpl
    with ChangeNotifier
    implements WordFieldController {
  _WordFieldControllerImpl({
    required this.correctWord,
    required bool safeMode,
    WordFieldValidator? validator,
    WordFieldWriter? writer,
    WordFieldEraser? eraser,
    WordFieldShaker? shaker,
  })  : letterFieldsControllers = List.generate(
          correctWord.length,
          (index) => LetterFieldController(safeMode: safeMode),
        ),
        _validator = validator ?? DefaultWordFieldValidator(safeMode),
        _writer = writer ?? DefaultWordFieldWriter(safeMode),
        _eraser = eraser ?? DefaultWordFieldEraser(safeMode),
        _shaker = shaker ?? DefaultWordFieldShaker() {
    state = WordFieldState.initial(
      letterStates: letterFieldsControllers.map((e) => e.state).toList(),
    );

    _subscribeToLetterFieldControllers();
  }

  @override
  final String correctWord;
  final List<LetterFieldController> letterFieldsControllers;
  final WordFieldValidator _validator;
  final WordFieldWriter _writer;
  final WordFieldEraser _eraser;
  final WordFieldShaker _shaker;

  @override
  late WordFieldState state;

  @override
  void addLetter(String letter) {
    _writer.writeLetter(
      letterFieldsControllers,
      state,
      letter,
    );
  }

  @override
  void eraseLetter() {
    _eraser.eraseLetter(
      letterFieldsControllers,
      state,
    );
  }

  @override
  void validate() {
    _validator.validate(
      letterFieldsControllers,
      state,
      correctWord,
    );
  }

  @override
  void shake() {
    _shaker.shake(letterFieldsControllers);
  }

  @override
  void clear() {
    _clearAllLetters();
  }

  @override
  void dispose() {
    _unsubscribeFromLetterFieldControllers();
    _disposeControllers();
    super.dispose();
  }

  void _subscribeToLetterFieldControllers() {
    for (int i = 0; i < letterFieldsControllers.length; i++) {
      letterFieldsControllers[i].addListener(() {
        _letterFieldControllerListener(i);
      });
    }
  }

  void _unsubscribeFromLetterFieldControllers() {
    for (int i = 0; i < letterFieldsControllers.length; i++) {
      letterFieldsControllers[i].removeListener(() {
        _letterFieldControllerListener(i);
      });
    }
  }

  void _letterFieldControllerListener(int index) {
    final newState = letterFieldsControllers[index].state;
    final newValidationStatus = _getNewValidationStatus(newState, index);
    final newStates = state.letterStates.withReplacedAt(index, newState);

    state = WordFieldState(
      letterStates: newStates,
      validationStatus: newValidationStatus,
    );

    notifyListeners();
  }

  WordFieldValidationStatus _getNewValidationStatus(
    LetterFieldState newLetterState,
    int letterIndex,
  ) {
    final isLast = letterIndex == letterFieldsControllers.length - 1;

    return switch (newLetterState) {
      EmptyLetterFieldState() => WordFieldValidationStatus.notValidated,
      FilledLetterFieldState(validationStatus: final validationStatus) =>
        switch (validationStatus) {
          LetterValidationStatus.notValidated =>
            WordFieldValidationStatus.notValidated,
          LetterValidationStatus.absent => WordFieldValidationStatus.incorrect,
          LetterValidationStatus.wrongPlacement =>
            WordFieldValidationStatus.incorrect,
          LetterValidationStatus.correct => switch (state.validationStatus) {
              WordFieldValidationStatus.notValidated => isLast
                  ? WordFieldValidationStatus.correct
                  : state.validationStatus,
              WordFieldValidationStatus.incorrect => state.validationStatus,
              WordFieldValidationStatus.correct => state.validationStatus,
            },
        },
    };
  }

  void _clearAllLetters() {
    for (final controller in letterFieldsControllers) {
      controller.clear();
    }
  }

  void _disposeControllers() {
    for (final letterController in letterFieldsControllers) {
      letterController.dispose();
    }
  }
}

typedef HandleErrorCallback = void Function(String message);
