import 'package:wordle/core/core.dart';

export 'hive_used_words_local_provider.dart';

abstract class UsedWordsLocalProvider {
  Future<Result<FetchFailure, List<String>>> getUsedWords();

  Future<Result<FetchFailure, void>> addWord(String word);

  Future<Result<FetchFailure, void>> removeWordsAddedBeforeDate(DateTime date);

  Future<Result<FetchFailure, void>> deleteAll();
}
