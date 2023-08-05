part of 'word_field.dart';

abstract interface class WordFieldController implements Listenable {
  factory WordFieldController({
    required String correctWord,
    bool safeMode = false,
    WordFieldValidator? validator,
    WordFieldWriter? letterWriter,
    WordFieldEraser? letterEraser,
  }) {
    return _WordFieldControllerImpl(
      correctWord: correctWord,
      safeMode: safeMode,
      validator: validator,
      eraser: letterEraser,
      writer: letterWriter,
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
      _updateStateFromControllers,
    );
  }

  @override
  void eraseLetter() {
    _eraser.eraseLetter(
      letterFieldsControllers,
      state,
      _updateStateFromControllers,
    );
  }

  @override
  void validate() {
    _validator.validate(
      letterFieldsControllers,
      state,
      correctWord,
      _updateStateFromControllers,
    );
  }

  @override
  void shake() {
    _shaker.shake(letterFieldsControllers);
  }

  @override
  void clear() {
    _clearAllLetters();
    _updateStateFromControllers();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  WordFieldState _getStateFromControllers() {
    final List<LetterFieldState> letterStates = [];

    WordFieldValidationStatus wordFieldValidationStatus =
        WordFieldValidationStatus.correct;

    for (int i = 0; i < letterFieldsControllers.length; i++) {
      final letterState = letterFieldsControllers[i].state;

      letterStates.add(letterState);

      if (wordFieldValidationStatus == WordFieldValidationStatus.notValidated) {
        continue;
      }

      final bool isNotValidated = letterState is EmptyLetterFieldState ||
          (letterState is FilledLetterFieldState &&
              letterState.validationStatus ==
                  LetterValidationStatus.notValidated);

      if (isNotValidated) {
        wordFieldValidationStatus = WordFieldValidationStatus.notValidated;
        continue;
      }

      if (wordFieldValidationStatus == WordFieldValidationStatus.incorrect) {
        continue;
      }

      final bool isIncorrect = letterState is FilledLetterFieldState &&
          (letterState.validationStatus == LetterValidationStatus.absent ||
              letterState.validationStatus ==
                  LetterValidationStatus.wrongPlacement);

      if (isIncorrect) {
        wordFieldValidationStatus = WordFieldValidationStatus.incorrect;
      }
    }

    return WordFieldState(
      letterStates: letterStates,
      validationStatus: wordFieldValidationStatus,
    );
  }

  void _updateStateFromControllers() {
    state = _getStateFromControllers();
    notifyListeners();
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
