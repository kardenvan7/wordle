part of 'wordle_field.dart';

abstract interface class WordleFieldListenable {
  Stream<WordleFieldState> get stateStream;

  WordleFieldState get state;

  List<WordFieldListenable> get wordFieldsListenables;
}

abstract interface class WordleFieldController
    implements WordleFieldListenable {
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

  void addLetter(String letter);

  void eraseLetter();

  void validate();

  void clearCurrentWordField();

  void clearAll();

  void dispose();
}

final class _WordleFieldControllerImpl
    with ErrorHandlerMixin
    implements WordleFieldController {
  _WordleFieldControllerImpl({
    required String correctWord,
    required int attemptsCount,
    required this.safeMode,
  }) : wordFieldControllers = List.generate(
          attemptsCount,
          (index) => WordFieldController(
            correctWord: correctWord,
            safeMode: safeMode,
          ),
        ) {
    _state = NotFinishedWordleFieldState(
      currentAttempt: 1,
      wordsFieldsStates: wordFieldControllers.map((e) => e.state).toList(),
    );
  }
  @override
  final bool safeMode;
  @override
  List<WordFieldListenable> get wordFieldsListenables => wordFieldControllers;

  @override
  Stream<WordleFieldState> get stateStream => _stateController.stream;

  @override
  WordleFieldState get state => _state;

  final StreamController<WordleFieldState> _stateController =
      StreamController.broadcast();

  final List<WordFieldController> wordFieldControllers;

  late WordleFieldState _state;

  int _currentWordControllerIndex = 0;

  List<WordFieldState> get _wordFieldStates =>
      wordFieldControllers.map((e) => e.state).toList();

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

      _setState(
        NotFinishedWordleFieldState(
          currentAttempt: _currentAttempt,
          wordsFieldsStates: _wordFieldStates,
        ),
      );
    }
  }

  void _updateState() {
    switch (_currentWordController.state.validationStatus) {
      case WordFieldValidationStatus.correct:
        _setState(
          FinishedWordleFieldState(
            attemptsCount: _currentAttempt,
            result: FinishedWordleFieldResult.won,
            wordsFieldsStates: _wordFieldStates,
          ),
        );

        break;

      case WordFieldValidationStatus.incorrect:
        if (_isLastAttempt) {
          _setState(
            FinishedWordleFieldState(
              attemptsCount: _currentAttempt,
              result: FinishedWordleFieldResult.lost,
              wordsFieldsStates: _wordFieldStates,
            ),
          );
        } else {
          _jumpToNextAttempt();
        }

        break;

      case WordFieldValidationStatus.notValidated:
        _setState(
          NotFinishedWordleFieldState(
            currentAttempt: _currentAttempt,
            wordsFieldsStates: _wordFieldStates,
          ),
        );

        break;
    }
  }

  void _setState(WordleFieldState state) {
    _state = state;
    _stateController.add(state);
  }
}
