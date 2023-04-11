import 'package:wordle/core/core.dart';
import 'package:wordle/features/wordle/domain/repositories_interfaces/used_words_repository.dart';
import 'package:wordle/features/wordle/domain/repositories_interfaces/words_repository.dart';

abstract class RandomWordleWordsService {
  Future<Result<FetchFailure, String>> getRandomWord({
    required int wordLength,
  });
}

class RandomWordleWordsServiceImpl implements RandomWordleWordsService {
  const RandomWordleWordsServiceImpl({
    required RandomWordsRepository wordsRepository,
    required UsedWordsRepository usedWordsRepository,
  })  : _wordsRepository = wordsRepository,
        _usedWordsRepository = usedWordsRepository;

  final RandomWordsRepository _wordsRepository;
  final UsedWordsRepository _usedWordsRepository;

  @override
  Future<Result<FetchFailure, String>> getRandomWord({
    required int wordLength,
  }) async {
    final wordFetchResult = await _wordsRepository.getRandomWord(
      length: wordLength,
      excludedWords: await _getUsedWords(),
    );

    return wordFetchResult.fold(
      onFailure: Result.failure,
      onSuccess: (word) {
        _usedWordsRepository.addWord(word);

        return Result.success(word);
      },
    );
  }

  Future<List<String>?> _getUsedWords() async {
    final usedWordsFetchResult = await _usedWordsRepository.getUsedWords();

    return usedWordsFetchResult.fold(
      onFailure: (_) => null,
      onSuccess: (words) => words,
    );
  }
}
