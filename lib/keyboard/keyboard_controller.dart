part of 'wordle_keyboard.dart';

abstract interface class KeyboardListenable {
  Stream<KeyboardAction> get actionsStream;
}

abstract interface class KeyboardController implements KeyboardListenable {
  factory KeyboardController() {
    return _KeyboardControllerImpl();
  }

  void onKeyPressed(KeyboardAction action);
}

final class _KeyboardControllerImpl implements KeyboardController {
  _KeyboardControllerImpl();

  final StreamController<KeyboardAction> _streamController =
      StreamController.broadcast();

  @override
  Stream<KeyboardAction> get actionsStream =>
      _streamController.stream.asBroadcastStream();

  @override
  void onKeyPressed(KeyboardAction action) {
    _streamController.add(action);
  }
}
