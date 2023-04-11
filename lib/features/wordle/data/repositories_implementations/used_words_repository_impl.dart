import 'package:wordle/core/src/failures/failure.dart';
import 'package:wordle/core/src/result.dart';
import 'package:wordle/features/wordle/data/providers/local/used_words/used_words_local_provider.dart';
import 'package:wordle/features/wordle/domain/repositories_interfaces/used_words_repository.dart';

export 'package:wordle/features/wordle/domain/repositories_interfaces/used_words_repository.dart';

class UsedWordsRepositoryImpl implements UsedWordsRepository {
  const UsedWordsRepositoryImpl({
    required Duration expirationDuration,
    required UsedWordsLocalProvider localProvider,
  })  : _expirationDuration = expirationDuration,
        _localProvider = localProvider;

  final Duration _expirationDuration;
  final UsedWordsLocalProvider _localProvider;

  Future<Result<FetchFailure, void>> checkAndCleanExpiredUsedWords() async {
    return _localProvider.removeWordsAddedBeforeDate(
      _expiredWordsLatestAdditionDate,
    );
  }

  @override
  Future<Result<FetchFailure, void>> addWord(String word) {
    return _localProvider.addWord(word);
  }

  @override
  Future<Result<FetchFailure, void>> deleteAll() {
    return _localProvider.deleteAll();
  }

  @override
  Future<Result<FetchFailure, List<String>>> getUsedWords() {
    return _localProvider.getUsedWords();
  }

  DateTime get _expiredWordsLatestAdditionDate {
    final DateTime now = DateTime.now();

    return DateTime.fromMillisecondsSinceEpoch(
      now.millisecondsSinceEpoch - _expirationDuration.inMilliseconds,
    );
  }
}
