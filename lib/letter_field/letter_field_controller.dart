part of 'letter_field.dart';

abstract interface class LetterFieldController implements Listenable {
  factory LetterFieldController({
    LetterFieldState initialState = const EmptyLetterFieldState(),
    bool safeMode = false,
  }) {
    return _LetterFieldControllerImpl(
      initialState: initialState,
      safeMode: safeMode,
    );
  }

  LetterFieldState get state;

  Stream<LetterFieldEvent> get eventStream;

  void setLetter(String letter);

  void eraseLetter();

  void setValidationStatus(LetterValidationStatus status);

  void shake();

  void clear();

  void dispose();
}

final class _LetterFieldControllerImpl
    with ChangeNotifier, SafeModeMixin, EventStreamMixin<LetterFieldEvent>
    implements LetterFieldController {
  _LetterFieldControllerImpl({
    required LetterFieldState initialState,
    required this.safeMode,
    LetterFieldShaker shaker = const DefaultLetterFieldShaker(),
  })  : _shaker = shaker,
        state = initialState;

  @override
  final bool safeMode;

  @override
  LetterFieldState state;

  final LetterFieldShaker _shaker;

  @override
  void setLetter(String letter) {
    final currentState = state;

    switch (currentState) {
      case EmptyLetterFieldState():
        _setLetter(letter);

      case FilledLetterFieldState():
        return handleError('Letter setting called on filled letter field');
    }
  }

  @override
  void eraseLetter() {
    final currentState = state;

    switch (currentState) {
      case EmptyLetterFieldState():
        return handleError('Letter erase called on empty letter field');

      case FilledLetterFieldState():
        _eraseLetter();
    }
  }

  @override
  void setValidationStatus(LetterValidationStatus status) {
    final currentState = state;

    switch (currentState) {
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
  void shake() {
    _shaker.shake((type) => addEvent(ShakeLetterFieldEvent(type: type)));
  }

  @override
  void clear() {
    _setState(const EmptyLetterFieldState());
  }

  void _setLetter(String letter) {
    _setState(
      FilledLetterFieldState(
        letter: letter,
        validationStatus: LetterValidationStatus.notValidated,
      ),
    );
  }

  void _eraseLetter() {
    _setState(const EmptyLetterFieldState());
  }

  void _setValidationStatus(
    String letter,
    LetterValidationStatus status,
  ) {
    _setState(
      FilledLetterFieldState(
        letter: letter,
        validationStatus: status,
      ),
    );
  }

  void _setState(LetterFieldState state) {
    this.state = state;
    notifyListeners();
  }
}

sealed class LetterFieldEvent {}

class ShakeLetterFieldEvent implements LetterFieldEvent {
  const ShakeLetterFieldEvent({
    required this.type,
  });

  final LetterFieldShakeType type;
}
