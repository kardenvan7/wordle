part of 'letter_field.dart';

abstract interface class LetterFieldListenable {
  /// Current state of the field
  ///
  LetterFieldState get state;

  /// Stream of field states
  ///
  Stream<LetterFieldState> get stateStream;

  /// Stream of one-time ui events that should not be stored in state
  ///
  Stream<LetterFieldEvent> get uiEventStream;
}

abstract interface class LetterFieldController
    implements LetterFieldListenable {
  factory LetterFieldController({
    LetterFieldState initialState = const EmptyLetterFieldState(),
    bool safeMode = false,
    LetterFieldShaker shaker = const DefaultLetterFieldShaker(),
  }) {
    return _LetterFieldControllerImpl(
      initialState: initialState,
      safeMode: safeMode,
      shaker: shaker,
    );
  }

  void setLetter(String letter);

  void eraseLetter();

  void setValidationStatus(LetterValidationStatus status);

  void shake();

  void clear();

  void dispose();
}

final class _LetterFieldControllerImpl
    with ErrorHandlerMixin
    implements LetterFieldController {
  _LetterFieldControllerImpl({
    required LetterFieldState initialState,
    required this.safeMode,
    required LetterFieldShaker shaker,
  })  : _shaker = shaker,
        _state = initialState;

  @override
  final bool safeMode;
  final LetterFieldShaker _shaker;

  @override
  LetterFieldState get state => _state;

  @override
  Stream<LetterFieldState> get stateStream => _stateStreamController.stream;

  @override
  Stream<LetterFieldEvent> get uiEventStream => _uiEventStreamController.stream;

  LetterFieldState _state;

  final StreamController<LetterFieldState> _stateStreamController =
      StreamController<LetterFieldState>.broadcast();
  final StreamController<LetterFieldEvent> _uiEventStreamController =
      StreamController<LetterFieldEvent>.broadcast();

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
    _shaker.shake(
      (type) => _uiEventStreamController.add(
        ShakeLetterFieldEvent(type: type),
      ),
    );
  }

  @override
  void clear() {
    _setState(const EmptyLetterFieldState());
  }

  @override
  void dispose() {
    _uiEventStreamController.close();
    _stateStreamController.close();
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
    _state = state;
    _stateStreamController.add(state);
  }
}

sealed class LetterFieldEvent {}

class ShakeLetterFieldEvent implements LetterFieldEvent {
  const ShakeLetterFieldEvent({
    required this.type,
  });

  final LetterFieldShakeType type;
}
