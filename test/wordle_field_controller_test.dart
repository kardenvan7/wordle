import 'package:flutter_test/flutter_test.dart';
import 'package:wordle/wordle_field/wordle_field.dart';

void main() {
  group(
    'Wordle field controller tests',
    () {
      const correctWord = 'cloth';
      const incorrectWord = 'crest';
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

          expect(
            uut.state,
            const NotFinishedWordleFieldState(currentAttempt: 1),
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

          expect(
            uut.state,
            const NotFinishedWordleFieldState(currentAttempt: 2),
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

          expect(
            uut.state,
            const NotFinishedWordleFieldState(currentAttempt: 2),
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

          expect(
            uut.state,
            const NotFinishedWordleFieldState(currentAttempt: 1),
          );

          for (int i = 0; i < incorrectWord.length; i++) {
            uut.addLetter(incorrectWord[i]);
          }

          uut.validate();
          uut.clearCurrentWordField();

          expect(
            uut.state,
            const NotFinishedWordleFieldState(currentAttempt: 2),
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
          expect(
            uut.state,
            const NotFinishedWordleFieldState(currentAttempt: 2),
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

          expect(
            uut.state,
            const FinishedWordleFieldState(
              attemptsCount: 1,
              result: FinishedWordleFieldResult.won,
            ),
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
            expect(
              uut.state,
              NotFinishedWordleFieldState(
                currentAttempt: attemptCount,
              ),
            );

            for (int i = 0; i < incorrectWord.length; i++) {
              uut.addLetter(incorrectWord[i]);
            }

            uut.validate();
          }

          expect(
            uut.state,
            const FinishedWordleFieldState(
              attemptsCount: attemptsCount,
              result: FinishedWordleFieldResult.lost,
            ),
          );
        },
      );
    },
  );
}
