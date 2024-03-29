import 'dart:async';

import 'package:flutter/material.dart';

part 'keyboard_action.dart';
part 'keyboard_controller.dart';
part 'wordle_keyboard_letter_key.dart';

class WordleKeyboard extends StatefulWidget {
  const WordleKeyboard({
    required this.controller,
    super.key,
  });

  final KeyboardController controller;

  @override
  State<WordleKeyboard> createState() => _WordleKeyboardState();
}

class _WordleKeyboardState extends State<WordleKeyboard> {
  final List<String> _firstRowLetters = [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P'
  ];

  final List<String> _secondRowLetters = [
    'A',
    'S',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
  ];

  final List<String> _thirdRowLetters = [
    'Z',
    'X',
    'C',
    'V',
    'B',
    'N',
    'M',
  ];

  void _onKeyPressed(KeyboardAction action) {
    widget.controller.onKeyPressed(action);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: List.generate(
            _firstRowLetters.length,
            (index) => Expanded(
              child: WordleKeyboardKey(
                action: LetterKeyboardAction(_firstRowLetters[index]),
                onPressed: _onKeyPressed,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            _secondRowLetters.length,
            (index) => Expanded(
              child: WordleKeyboardKey(
                action: LetterKeyboardAction(_secondRowLetters[index]),
                onPressed: _onKeyPressed,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              _thirdRowLetters.length,
              (index) => Expanded(
                child: WordleKeyboardKey(
                  action: LetterKeyboardAction(_thirdRowLetters[index]),
                  onPressed: _onKeyPressed,
                ),
              ),
            ),
            Expanded(
              child: WordleKeyboardKey(
                action: const EraseKeyboardAction(),
                onPressed: _onKeyPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
