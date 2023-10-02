part of 'wordle_keyboard.dart';

sealed class KeyboardAction {}

final class LetterKeyboardAction implements KeyboardAction {
  const LetterKeyboardAction(this.letter);

  final String letter;

  @override
  int get hashCode => letter.hashCode;

  @override
  bool operator ==(Object other) {
    return other is LetterKeyboardAction && letter == other.letter;
  }
}

final class EraseKeyboardAction implements KeyboardAction {
  const EraseKeyboardAction();

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  bool operator ==(Object other) => other is EraseKeyboardAction;
}
