part of 'wordle_field.dart';

abstract interface class WordleFieldController {
  factory WordleFieldController({
    required String correctWord,
    required int attemptsCount,
    bool safeMode = false,
  }) {
    return _WordleFieldControllerImpl(
      correctWord: correctWord,
      attemptsCount: attemptsCount,
      safeMode: safeMode,
    );
  }

  String get correctWord;

  int get attemptsCount;

  ValueListenable<WordleFieldState> get listenable;

  WordleFieldState get state;

  void addLetter(String letter);

  void eraseLetter();

  void validate();

  void clearCurrentWordField();

  void clearAll();

  void dispose();
}

class _WordleFieldControllerImpl
    with SafeModeMixin
    implements WordleFieldController {
  _WordleFieldControllerImpl({
    required this.correctWord,
    required this.attemptsCount,
    required this.safeMode,
  })  : wordFieldControllers = List.generate(
          attemptsCount,
          (index) => WordFieldController(
            correctWord: correctWord,
            safeMode: safeMode,
          ),
        ),
        _valueNotifier = ValueNotifier(
          const NotFinishedWordleFieldState(currentAttempt: 1),
        );

  @override
  final String correctWord;
  @override
  final int attemptsCount;
  @override
  final bool safeMode;

  final ValueNotifier<WordleFieldState> _valueNotifier;
  final List<WordFieldController> wordFieldControllers;

  int _currentWordControllerIndex = 0;

  @override
  ValueListenable<WordleFieldState> get listenable => _valueNotifier;

  @override
  WordleFieldState get state => _valueNotifier.value;

  @override
  void addLetter(String letter) {
    if (_isFinished) {
      throw Exception('Can not add letter in finished wordle field');
    }

    _currentWordController.addLetter(letter);
  }

  @override
  void eraseLetter() {
    if (_isFinished) {
      throw Exception('Can not erase letter in finished wordle field');
    }

    _currentWordController.eraseLetter();
  }

  @override
  void validate() {
    if (_isFinished) {
      throw Exception('Can not validate finished wordle field');
    }

    _currentWordController.validate();
    _updateState();
  }

  @override
  void clearCurrentWordField() {
    _currentWordController.clear();
    _updateState();
  }

  @override
  void clearAll() {
    for (final controller in wordFieldControllers) {
      controller.clear();
    }

    _currentWordControllerIndex = 0;
    _updateState();
  }

  @override
  void dispose() {
    for (final controller in wordFieldControllers) {
      controller.dispose();
    }
  }

  int get _currentAttempt => _currentWordControllerIndex + 1;

  bool get _isLastAttempt => _currentAttempt == wordFieldControllers.length;

  WordFieldController get _currentWordController =>
      wordFieldControllers[_currentWordControllerIndex];

  bool get _isFinished => state is FinishedWordleFieldState;

  void _jumpToNextAttempt() {
    if (_currentWordControllerIndex < wordFieldControllers.length) {
      _currentWordControllerIndex++;

      _valueNotifier.value = NotFinishedWordleFieldState(
        currentAttempt: _currentAttempt,
      );
    }
  }

  void _updateState() {
    switch (_currentWordController.state.validationStatus) {
      case WordFieldValidationStatus.correct:
        _valueNotifier.value = FinishedWordleFieldState(
          attemptsCount: _currentAttempt,
          result: FinishedWordleFieldResult.won,
        );

        break;

      case WordFieldValidationStatus.incorrect:
        if (_isLastAttempt) {
          _valueNotifier.value = FinishedWordleFieldState(
            attemptsCount: _currentAttempt,
            result: FinishedWordleFieldResult.lost,
          );
        } else {
          _jumpToNextAttempt();
        }

        break;

      case WordFieldValidationStatus.notValidated:
        _valueNotifier.value = NotFinishedWordleFieldState(
          currentAttempt: _currentAttempt,
        );

        break;
    }
  }
}
