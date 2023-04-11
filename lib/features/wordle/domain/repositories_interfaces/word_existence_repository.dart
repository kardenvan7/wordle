import 'package:wordle/core/core.dart';

abstract class WordExistenceRepository {
  Future<Result<FetchFailure, bool>> exists(String word);
}
