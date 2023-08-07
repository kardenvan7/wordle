import 'package:flutter/material.dart';
import 'package:wordle/keyboard/wordle_keyboard.dart';
import 'package:wordle/wordle_field/wordle_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final WordleFieldController _wordleFieldController;

  @override
  void initState() {
    _wordleFieldController = WordleFieldController(
      attemptsCount: 6,
      correctWord: 'cloth',
    );

    super.initState();
  }

  void _onKeyPressed(KeyboardAction action) {
    switch (action) {
      case LetterKeyboardAction(letter: final letter):
        _addLetter(letter);
        break;
      case EraseKeyboardAction():
        _removeLetter();
        break;
    }
  }

  void _addLetter(String letter) {
    _wordleFieldController.addLetter(letter);
  }

  void _removeLetter() {
    _wordleFieldController.eraseLetter();
  }

  void _validate() {
    _wordleFieldController.validate();
  }

  void _clearCurrentWord() {
    _wordleFieldController.clearCurrentWordField();
  }

  void _clearAll() {
    _wordleFieldController.clearAll();
  }

  @override
  void dispose() {
    _wordleFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10,
              ) +
              const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WordleField(
                wordleFieldController: _wordleFieldController,
              ),
              Wrap(
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _validate,
                    child: const Text('Validate'),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: _clearCurrentWord,
                    child: const Text('Clear current word'),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: _clearAll,
                    child: const Text('Clear all'),
                  ),
                ],
              ),
              WordleKeyboard(
                onKeyPressed: _onKeyPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
