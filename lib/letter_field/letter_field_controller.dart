part of 'letter_field.dart';

abstract interface class LetterFieldController {
  factory LetterFieldController({
    LetterFieldState initialState,
  }) = _UnsafeLetterFieldController;

  factory LetterFieldController.safe({
    LetterFieldState initialState,
  }) = _SafeLetterFieldController;

  ValueListenable<LetterFieldState> get listenable;

  LetterFieldState get state;

  void setLetter(String letter);

  void eraseLetter();

  void setValidationStatus(LetterValidationStatus status);

  void clear();

  void dispose();
}

abstract class _LetterFieldControllerImpl implements LetterFieldController {
  _LetterFieldControllerImpl({
    LetterFieldState initialState = const EmptyLetterFieldState(),
  }) : _valueNotifier = ValueNotifier(initialState);

  final ValueNotifier<LetterFieldState> _valueNotifier;

  @override
  ValueListenable<LetterFieldState> get listenable => _valueNotifier;

  @override
  LetterFieldState get state => listenable.value;

  String get _currentLetter => switch (state) {
        EmptyLetterFieldState() => ' ',
        FilledLetterFieldState(letter: final letter) => letter,
      };

  @override
  void setLetter(String letter) {
    _valueNotifier.value = FilledLetterFieldState(
      letter: letter,
      validationStatus: LetterValidationStatus.notValidated,
    );
  }

  @override
  void eraseLetter() {
    _valueNotifier.value = const EmptyLetterFieldState();
  }

  @override
  void setValidationStatus(
    LetterValidationStatus status,
  ) {
    _valueNotifier.value = FilledLetterFieldState(
      letter: _currentLetter,
      validationStatus: status,
    );
  }

  @override
  void clear() {
    _valueNotifier.value = const EmptyLetterFieldState();
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
  }
}

class _SafeLetterFieldController extends _LetterFieldControllerImpl {
  _SafeLetterFieldController({
    super.initialState,
  });
}

class _UnsafeLetterFieldController extends _LetterFieldControllerImpl {
  _UnsafeLetterFieldController({
    super.initialState,
  });

  @override
  void setLetter(String letter) {
    final currentValue = _valueNotifier.value;

    switch (currentValue) {
      case EmptyLetterFieldState():
        _setLetter(letter);

      case FilledLetterFieldState():
        throw Exception('Letter setting called on filled letter field');
    }
  }

  @override
  void eraseLetter() {
    final currentValue = _valueNotifier.value;

    switch (currentValue) {
      case EmptyLetterFieldState():
        throw Exception('Letter erase called on empty letter field');

      case FilledLetterFieldState():
        _eraseLetter();
    }
  }

  @override
  void setValidationStatus(LetterValidationStatus status) {
    final currentValue = _valueNotifier.value;

    switch (currentValue) {
      case EmptyLetterFieldState():
        throw Exception('Validation called on empty letter field');

      case FilledLetterFieldState(
          letter: String letter,
          validationStatus: LetterValidationStatus curStatus,
        ):
        switch (curStatus) {
          case LetterValidationStatus.notValidated:
            _setValidationStatus(letter, status);
            break;

          default:
            throw Exception(
              'Validation called on already validated letter field',
            );
        }
    }
  }

  @override
  void clear() {
    _valueNotifier.value = const EmptyLetterFieldState();
  }

  void _setLetter(String letter) {
    _valueNotifier.value = FilledLetterFieldState(
      letter: letter,
      validationStatus: LetterValidationStatus.notValidated,
    );
  }

  void _eraseLetter() {
    _valueNotifier.value = const EmptyLetterFieldState();
  }

  void _setValidationStatus(
    String letter,
    LetterValidationStatus status,
  ) {
    _valueNotifier.value = FilledLetterFieldState(
      letter: letter,
      validationStatus: status,
    );
  }
}
