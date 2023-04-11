import 'package:wordle/core/core.dart';

abstract class RandomWordsRepository {
  Future<Result<FetchFailure, String>> getRandomWord({
    required int length,
    List<String>? excludedWords,
  });
}
