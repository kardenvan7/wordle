import 'package:wordle/core/core.dart';

abstract class UsedWordsRepository {
  Future<Result<FetchFailure, List<String>>> getUsedWords();

  Future<Result<FetchFailure, void>> addWord(String word);

  Future<Result<FetchFailure, void>> deleteAll();
}
