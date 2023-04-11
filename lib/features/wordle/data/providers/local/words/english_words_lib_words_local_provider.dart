import 'package:english_words/english_words.dart';
import 'package:wordle/core/src/failures/failure.dart';
import 'package:wordle/core/src/result.dart';
import 'package:wordle/features/wordle/data/providers/local/words/words_local_provider.dart';

class EnglishWordsLibWordsLocalProvider implements WordsLocalProvider {
  const EnglishWordsLibWordsLocalProvider();

  @override
  Future<Result<FetchFailure, List<String>>> getAllWords(
    int length,
  ) async {
    return Result.success(nouns);
  }
}
