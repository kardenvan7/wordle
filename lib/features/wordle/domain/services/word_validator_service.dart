import 'package:wordle/core/core.dart';
import 'package:wordle/features/wordle/domain/repositories_interfaces/word_existence_repository.dart';

import '../models/validated_character/validated_character.dart';

export '../models/validated_character/validated_character.dart';

abstract class WordValidationService {
  Future<Result<WordValidationFailure, List<ValidatedCharacter>>> validate(
    String word,
    String validWord,
  );
}

class WordValidatorServiceImpl implements WordValidationService {
  const WordValidatorServiceImpl({
    required WordExistenceRepository wordExistenceRepository,
  }) : _wordExistenceRepository = wordExistenceRepository;

  final WordExistenceRepository _wordExistenceRepository;

  @override
  Future<Result<WordValidationFailure, List<ValidatedCharacter>>> validate(
    String word,
    String validWord,
  ) async {
    if (word.length != validWord.length) {
      return Result.failure(WordValidationFailure.incorrectWordLength);
    }

    final wordExistsResult = await _wordExistenceRepository.exists(word);

    return wordExistsResult.fold(
      onFailure: (_) => Result.failure(WordValidationFailure.unknown),
      onSuccess: (bool isValid) {
        return Result.success(_getValidatedCharacters(word, validWord));
      },
    );
  }

  List<ValidatedCharacter> _getValidatedCharacters(
    String word,
    String validWord,
  ) {
    final List<ValidatedCharacter> validatedChars = [];

    for (int index = 0; index < word.length; index++) {
      final ValidatedCharacter validatedCharacter = _getValidatedCharForIndex(
        word: word,
        validWord: validWord,
        indexUnderTest: index,
      );

      validatedChars.add(validatedCharacter);
    }

    return validatedChars;
  }

  ValidatedCharacter _getValidatedCharForIndex({
    required String word,
    required String validWord,
    required int indexUnderTest,
  }) {
    final charUnderValidation = word[indexUnderTest];
    late final ValidatedCharacterState state;

    if (validWord[indexUnderTest] == charUnderValidation) {
      state = ValidatedCharacterState.correct;
    } else if (validWord.contains(charUnderValidation)) {
      state = ValidatedCharacterState.presentInOtherPosition;
    } else {
      state = ValidatedCharacterState.notPresent;
    }

    return ValidatedCharacter(
      character: charUnderValidation,
      index: indexUnderTest,
      state: state,
    );
  }
}

enum WordValidationFailure {
  nonExistingWord,
  incorrectWordLength,
  unknown;
}
