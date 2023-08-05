part of 'wordle_keyboard.dart';

class WordleKeyboardKey extends StatelessWidget {
  const WordleKeyboardKey({
    required this.action,
    required this.onPressed,
    this.isDisabled = false,
    super.key,
  });

  final KeyboardAction action;
  final bool isDisabled;
  final void Function(KeyboardAction action) onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(),
      onPressed: isDisabled ? null : () => onPressed(action),
      child: switch (action) {
        LetterKeyboardAction(letter: final letter) => Text(letter),
        EraseKeyboardAction() => const Icon(Icons.arrow_back_rounded),
      },
    );
  }
}
