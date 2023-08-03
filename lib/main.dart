import 'package:flutter/material.dart';
import 'package:wordle/word_field/word_field.dart';

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
  late final WordFieldController _wordFieldController;

  @override
  void initState() {
    _wordFieldController = WordFieldController(correctWord: 'kek');

    super.initState();
  }

  void _addLetter() {
    _wordFieldController.addLetter('B');
  }

  void _removeLetter() {
    _wordFieldController.eraseLetter();
  }

  void _validate() {
    _wordFieldController.validate();
  }

  void _clear() {
    _wordFieldController.clear();
  }

  @override
  void dispose() {
    _wordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WordField(wordFieldController: _wordFieldController),
            const SizedBox(height: 24),
            Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _addLetter,
                  child: const Text('Add letter'),
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: _removeLetter,
                  child: const Text('Remove letter'),
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: _validate,
                  child: const Text('Validate'),
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: _clear,
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
