import 'package:wordle/core/core.dart';

abstract class WordsLocalProvider {
  Future<Result<FetchFailure, List<String>>> getAllWords(
    int length,
  );
}
