import 'package:flutter_test/flutter_test.dart';
import 'package:wordle/wordle_field/wordle_field.dart';

void main() {
  group(
    'Wordle field controller tests',
    () {
      const correctWord = 'cloth';
      const incorrectWord = 'crush';
      const attemptsCount = 5;

      WordleFieldController getUut() {
        return WordleFieldController(
          correctWord: correctWord,
          attemptsCount: attemptsCount,
        );
      }

      test(
        'Initial state is not finished with attempt #1',
        () {
          final uut = getUut();

          final state = uut.state;

          expect(
            state is NotFinishedWordleFieldState && state.currentAttempt == 1,
            true,
          );
        },
      );

      test(
        'Correctly updates attempt count',
        () {
          final uut = getUut();

          for (int i = 0; i < incorrectWord.length; i++) {
            uut.addLetter(incorrectWord[i]);
          }

          uut.validate();

          final state = uut.state;

          expect(
            state is NotFinishedWordleFieldState && state.currentAttempt == 2,
            true,
          );
        },
      );

      test(
        'Correctly updates attempt count',
        () {
          final uut = getUut();

          for (int i = 0; i < incorrectWord.length; i++) {
            uut.addLetter(incorrectWord[i]);
          }

          uut.validate();

          final state = uut.state;

          expect(
            state is NotFinishedWordleFieldState && state.currentAttempt == 2,
            true,
          );
        },
      );

      test(
        'Clears current word correctly',
        () {
          final uut = getUut();

          for (int i = 0; i < incorrectWord.length; i++) {
            uut.addLetter(incorrectWord[i]);
          }

          uut.clearCurrentWordField();

          final firstState = uut.state;

          expect(
            firstState is NotFinishedWordleFieldState &&
                firstState.currentAttempt == 1,
            true,
          );

          for (int i = 0; i < incorrectWord.length; i++) {
            uut.addLetter(incorrectWord[i]);
          }

          uut.validate();
          uut.clearCurrentWordField();

          final secondState = uut.state;

          expect(
            secondState is NotFinishedWordleFieldState &&
                secondState.currentAttempt == 2,
            true,
          );
        },
      );

      test(
        'Not going back to previous word',
        () {
          final uut = getUut();

          for (int i = 0; i < incorrectWord.length; i++) {
            uut.addLetter(incorrectWord[i]);
          }

          uut.validate();

          expect(() => uut.eraseLetter(), throwsException);

          final state = uut.state;

          expect(
            state is NotFinishedWordleFieldState && state.currentAttempt == 2,
            true,
          );
        },
      );

      test(
        'Correctly sets finished won state',
        () {
          final uut = getUut();

          for (int i = 0; i < correctWord.length; i++) {
            uut.addLetter(correctWord[i]);
          }

          uut.validate();

          final state = uut.state;

          expect(
            state is FinishedWordleFieldState &&
                state.result == FinishedWordleFieldResult.won,
            true,
          );
        },
      );

      test(
        'Correctly sets finished lost state',
        () {
          final uut = getUut();

          for (int attemptCount = 1;
              attemptCount <= attemptsCount;
              attemptCount++) {
            for (int i = 0; i < incorrectWord.length; i++) {
              uut.addLetter(incorrectWord[i]);
            }

            uut.validate();
          }

          final state = uut.state;

          expect(
            state is FinishedWordleFieldState &&
                state.result == FinishedWordleFieldResult.lost,
            true,
          );
        },
      );
    },
  );
}
