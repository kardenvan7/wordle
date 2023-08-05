import 'package:flutter_test/flutter_test.dart';
import 'package:wordle/letter_field/letter_field.dart';
import 'package:wordle/word_field/word_field.dart';

void main() {
  group(
    'Word field controller tests',
    () {
      const correctWord = 'bulk';

      WordFieldController getUut() {
        return WordFieldController(correctWord: correctWord);
      }

      test(
        'Initial state has empty letter states and validation state is "notValidated"',
        () {
          final uut = getUut();
          final state = uut.state;

          expect(
            state.letterStates.every(
              (element) => element is EmptyLetterFieldState,
            ),
            true,
          );

          expect(
            state.validationStatus,
            WordFieldValidationStatus.notValidated,
          );
        },
      );

      test(
        'Letter states count equals correct word length',
        () {
          final uut = getUut();
          final state = uut.state;

          expect(
            state.letterStates.length,
            correctWord.length,
          );
        },
      );

      test(
        'Correctly sets letters',
        () {
          final uut = getUut();

          for (int i = 0; i < uut.state.letterStates.length - 1; i++) {
            uut.addLetter(correctWord[i]);

            expect(
              uut.state.letterStates[i],
              FilledLetterFieldState(
                letter: correctWord[i],
                validationStatus: LetterValidationStatus.notValidated,
              ),
            );
          }
        },
      );

      test(
        'Correctly erases letters',
        () {
          final uut = getUut();

          for (int i = 0; i < correctWord.length; i++) {
            uut.addLetter(correctWord[i]);
          }

          for (int i = uut.correctWord.length - 1; i >= 0; i--) {
            uut.eraseLetter();

            expect(uut.state.letterStates[i], const EmptyLetterFieldState());
          }
        },
      );

      test(
        'Correctly validates correct word',
        () {
          final uut = getUut();

          for (int i = 0; i < correctWord.length; i++) {
            uut.addLetter(correctWord[i]);
          }

          uut.validate();

          expect(
            uut.state,
            WordFieldState(
              letterStates: List.generate(
                correctWord.length,
                (index) => FilledLetterFieldState(
                  letter: correctWord[index],
                  validationStatus: LetterValidationStatus.correct,
                ),
              ),
              validationStatus: WordFieldValidationStatus.correct,
            ),
          );
        },
      );

      test(
        'Correctly validates incorrect word',
        () {
          const typedWord = 'colb';

          assert(
            correctWord.length == typedWord.length,
            'Words in test must be same length',
          );

          final uut = getUut();

          for (int i = 0; i < typedWord.length; i++) {
            uut.addLetter(typedWord[i]);
          }

          uut.validate();

          expect(
            uut.state,
            WordFieldState(
              letterStates: List.generate(
                typedWord.length,
                (index) {
                  final letter = typedWord[index];
                  final correctLetter = correctWord[index];

                  return FilledLetterFieldState(
                    letter: letter,
                    validationStatus: letter == correctLetter
                        ? LetterValidationStatus.correct
                        : correctWord.contains(letter)
                            ? LetterValidationStatus.wrongPlacement
                            : LetterValidationStatus.absent,
                  );
                },
              ),
              validationStatus: WordFieldValidationStatus.incorrect,
            ),
          );
        },
      );
    },
  );
}
