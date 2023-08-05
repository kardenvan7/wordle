import 'package:flutter_test/flutter_test.dart';
import 'package:wordle/letter_field/letter_field.dart';

void main() {
  group(
    'Letter field controller tests',
    () {
      const letter = 'B';

      test(
        'Default initial state is empty state',
        () {
          final uut = LetterFieldController();

          expect(uut.state, const EmptyLetterFieldState());
        },
      );

      test(
        'Sets letter',
        () {
          final uut = LetterFieldController();

          uut.setLetter(letter);

          expect(
            uut.state,
            const FilledLetterFieldState(
              letter: letter,
              validationStatus: LetterValidationStatus.notValidated,
            ),
          );
        },
      );

      test(
        'Erases letter',
        () {
          final uut = LetterFieldController();

          uut.setLetter(letter);
          uut.eraseLetter();

          expect(
            uut.state,
            const EmptyLetterFieldState(),
          );
        },
      );

      test(
        'Sets letter validation status',
        () {
          final uut = LetterFieldController();
          const status = LetterValidationStatus.correct;

          uut.setLetter(letter);
          uut.setValidationStatus(status);

          expect(
            uut.state,
            const FilledLetterFieldState(
                letter: letter, validationStatus: status),
          );
        },
      );

      test(
        'Throws when letter is set on filled field',
        () {
          final uut = LetterFieldController();

          uut.setLetter(letter);

          expect(() => uut.setLetter(letter), throwsException);
        },
      );

      test(
        'Throws when erase is called on empty field',
        () {
          final uut = LetterFieldController();

          expect(() => uut.eraseLetter(), throwsException);
        },
      );

      test(
        'Throws when validating empty field',
        () {
          final uut = LetterFieldController();

          expect(
            () => uut.setValidationStatus(LetterValidationStatus.correct),
            throwsException,
          );
        },
      );
    },
  );
}
