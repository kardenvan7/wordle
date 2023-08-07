part of 'wordle_field.dart';

abstract interface class WordleFieldController implements Listenable {
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

  WordleFieldState get state;

  void addLetter(String letter);

  void eraseLetter();

  void validate();

  void clearCurrentWordField();

  void clearAll();

  void dispose();
}

class _WordleFieldControllerImpl
    with ChangeNotifier, SafeModeMixin
    implements WordleFieldController {
  _WordleFieldControllerImpl({
    required this.correctWord,
    required this.attemptsCount,
    required this.safeMode,
  }) : wordFieldControllers = List.generate(
          attemptsCount,
          (index) => WordFieldController(
            correctWord: correctWord,
            safeMode: safeMode,
          ),
        ) {
    state = _getInitialState();

    _subscribeToWordsFieldsControllers();
  }

  @override
  final String correctWord;
  @override
  final int attemptsCount;
  @override
  final bool safeMode;

  final List<WordFieldController> wordFieldControllers;

  @override
  late WordleFieldState state;

  WordFieldController get _currentWordController {
    final index = switch (state) {
      NotFinishedWordleFieldState(currentAttempt: final currentAttempt) =>
        currentAttempt - 1,
      FinishedWordleFieldState(attemptsCount: final attemptsCount) =>
        attemptsCount - 1,
    };

    return wordFieldControllers[index];
  }

  bool get _isFinished => state is FinishedWordleFieldState;

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
  }

  @override
  void clearCurrentWordField() {
    _currentWordController.clear();
  }

  @override
  void clearAll() {
    for (final controller in wordFieldControllers.reversed) {
      controller.clear();
    }
  }

  @override
  void dispose() {
    _unsubscribeFromWordsFieldsControllers();

    for (final controller in wordFieldControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void _subscribeToWordsFieldsControllers() {
    for (int i = 0; i < wordFieldControllers.length; i++) {
      wordFieldControllers[i].addListener(() {
        _wordFieldControllerListener(i);
      });
    }
  }

  void _unsubscribeFromWordsFieldsControllers() {
    for (int i = 0; i < wordFieldControllers.length; i++) {
      wordFieldControllers[i].addListener(() {
        _wordFieldControllerListener(i);
      });
    }
  }

  void _wordFieldControllerListener(int index) {
    final newWordState = wordFieldControllers[index].state;
    state = _getNewState(newWordState, index);

    notifyListeners();
  }

  WordleFieldState _getInitialState() {
    int i = 0;

    for (i; i < wordFieldControllers.length; i++) {
      if (!wordFieldControllers[i].state.isValidated) break;
    }

    return NotFinishedWordleFieldState(
      currentAttempt: i + 1,
      wordsFieldsStates: wordFieldControllers.map((e) => e.state).toList(),
    );
  }

  WordleFieldState _getNewState(
    WordFieldState newWordState,
    int index,
  ) {
    final newStates = state.wordsFieldsStates.withReplacedAt(
      index,
      newWordState,
    );
    final attempt = index + 1;
    final isLast = index == wordFieldControllers.length - 1;

    return switch (newWordState.validationStatus) {
      WordFieldValidationStatus.notValidated => NotFinishedWordleFieldState(
          currentAttempt: attempt,
          wordsFieldsStates: newStates,
        ),
      WordFieldValidationStatus.incorrect => isLast
          ? FinishedWordleFieldState(
              attemptsCount: attemptsCount,
              result: FinishedWordleFieldResult.lost,
              wordsFieldsStates: newStates,
            )
          : NotFinishedWordleFieldState(
              currentAttempt: attempt + 1,
              wordsFieldsStates: newStates,
            ),
      WordFieldValidationStatus.correct => FinishedWordleFieldState(
          attemptsCount: attemptsCount,
          result: FinishedWordleFieldResult.won,
          wordsFieldsStates: newStates,
        ),
    };
  }
}
