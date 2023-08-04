part of 'letter_field.dart';

abstract interface class LetterFieldController {
  factory LetterFieldController({
    LetterFieldState initialState = const EmptyLetterFieldState(),
    bool safeMode = false,
  }) {
    return _LetterFieldControllerImpl(
      initialState: initialState,
      safeMode: safeMode,
    );
  }

  ValueListenable<LetterFieldState> get listenable;

  LetterFieldState get state;

  void setLetter(String letter);

  void eraseLetter();

  void setValidationStatus(LetterValidationStatus status);

  void clear();

  void dispose();
}

class _LetterFieldControllerImpl
    with SafeModeMixin
    implements LetterFieldController {
  _LetterFieldControllerImpl({
    required LetterFieldState initialState,
    required this.safeMode,
  }) : _valueNotifier = ValueNotifier(initialState);

  @override
  final bool safeMode;

  final ValueNotifier<LetterFieldState> _valueNotifier;

  @override
  ValueListenable<LetterFieldState> get listenable => _valueNotifier;

  @override
  LetterFieldState get state => listenable.value;

  @override
  void setLetter(String letter) {
    final currentValue = _valueNotifier.value;

    switch (currentValue) {
      case EmptyLetterFieldState():
        _setLetter(letter);

      case FilledLetterFieldState():
        return handleError('Letter setting called on filled letter field');
    }
  }

  @override
  void eraseLetter() {
    final currentValue = _valueNotifier.value;

    switch (currentValue) {
      case EmptyLetterFieldState():
        return handleError('Letter erase called on empty letter field');

      case FilledLetterFieldState():
        _eraseLetter();
    }
  }

  @override
  void setValidationStatus(LetterValidationStatus status) {
    final currentValue = _valueNotifier.value;

    switch (currentValue) {
      case EmptyLetterFieldState():
        return handleError('Validation called on empty letter field');

      case FilledLetterFieldState(
          letter: String letter,
          validationStatus: LetterValidationStatus curStatus,
        ):
        switch (curStatus) {
          case LetterValidationStatus.notValidated:
            _setValidationStatus(letter, status);
            break;

          default:
            return handleError(
              'Validation called on already validated letter field',
            );
        }
    }
  }

  @override
  void clear() {
    _valueNotifier.value = const EmptyLetterFieldState();
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
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
