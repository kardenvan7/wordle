import 'dart:math';

import 'package:wordle/core/src/failures/failure.dart';
import 'package:wordle/core/src/result.dart';
import 'package:wordle/features/wordle/data/providers/local/words/words_local_provider.dart';
import 'package:wordle/features/wordle/domain/repositories_interfaces/words_repository.dart';

class RandomWordsRepositoryImpl implements RandomWordsRepository {
  const RandomWordsRepositoryImpl({
    required WordsLocalProvider wordsLocalProvider,
    required Random random,
  })  : _wordsLocalProvider = wordsLocalProvider,
        _random = random;

  final WordsLocalProvider _wordsLocalProvider;
  final Random _random;

  @override
  Future<Result<FetchFailure, String>> getRandomWord({
    required int length,
    List<String>? excludedWords,
  }) async {
    final allWordsFetchResult = await _wordsLocalProvider.getAllWords(length);

    return allWordsFetchResult.fold(
      onFailure: Result.failure,
      onSuccess: (words) {
        if (words.isEmpty) {
          return Result.failure(const LocalFetchFailure.notFound());
        }

        final String randomWord = _getRandomEligibleWord(words, excludedWords);

        return Result.success(randomWord);
      },
    );
  }

  String _getRandomEligibleWord(
    List<String> words,
    List<String>? excludedWords,
  ) {
    Iterable<String> eligibleWords = words;

    if (excludedWords != null && excludedWords.isNotEmpty) {
      bool isWordEligible(String word) {
        return excludedWords.contains(word);
      }

      eligibleWords = words.where(isWordEligible);
    }

    final randomIndex = _random.nextInt(eligibleWords.length);

    return eligibleWords.elementAt(randomIndex);
  }
}
