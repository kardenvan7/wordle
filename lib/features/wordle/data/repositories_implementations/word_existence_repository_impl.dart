import 'package:wordle/core/src/failures/failure.dart';
import 'package:wordle/core/src/result.dart';
import 'package:wordle/features/wordle/domain/repositories_interfaces/word_existence_repository.dart';

class WordExistenceRepositoryImpl implements WordExistenceRepository {
  @override
  Future<Result<FetchFailure, bool>> exists(String word) {
    // TODO: implement exists
    throw UnimplementedError();
  }
}
