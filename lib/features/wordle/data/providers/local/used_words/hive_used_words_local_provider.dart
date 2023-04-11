import 'package:wordle/core/core.dart';
import 'package:wordle/features/wordle/data/json_converters/date_time_json_converter.dart';
import 'package:wordle/hive/hive.dart';

import 'used_words_local_provider.dart';

typedef UsedWordsByDate = Map<DateTime, String>;
typedef UsedWordsByDateJson = Map<String, String>;

class HiveUsedWordsLocalProvider implements UsedWordsLocalProvider {
  const HiveUsedWordsLocalProvider({
    required HiveBoxFacade<UsedWordsByDateJson> boxFacade,
  }) : _boxFacade = boxFacade;

  final HiveBoxFacade<UsedWordsByDateJson> _boxFacade;
  final String _key = 'used_words';

  @override
  Future<Result<FetchFailure, void>> addWord(String word) async {
    final fetchResult = _boxFacade.read(_key);

    return fetchResult.fold(
      onFailure: Result.failure,
      onSuccess: (UsedWordsByDateJson wordsByDateOfAdditionJson) {
        final wordsByDate = UsedWordsByDate.from(
          _UsedWordsByDateSerializationExtension.fromJson(
            wordsByDateOfAdditionJson,
          ),
        );

        wordsByDate[DateTime.now()] = word;

        return _boxFacade.save(_key, wordsByDate.toJson());
      },
    );
  }

  @override
  Future<Result<FetchFailure, void>> deleteAll() {
    return _boxFacade.delete(_key);
  }

  @override
  Future<Result<FetchFailure, List<String>>> getUsedWords() {
    return Future.sync(
      () => _boxFacade.read(_key).fold(
            onFailure: Result.failure,
            onSuccess: (UsedWordsByDateJson wordsByAdditionDate) {
              return Result.success(wordsByAdditionDate.values.toList());
            },
          ),
    );
  }

  @override
  Future<Result<FetchFailure, void>> removeWordsAddedBeforeDate(
    DateTime date,
  ) async {
    final fetchResult = _boxFacade.read(_key);

    return fetchResult.fold(
      onFailure: Result.failure,
      onSuccess: (UsedWordsByDateJson wordsByDateOfAdditionJson) {
        final wordsByDate = UsedWordsByDate.from(
          _UsedWordsByDateSerializationExtension.fromJson(
            wordsByDateOfAdditionJson,
          ),
        );

        wordsByDate.removeWhere((date, word) => date.isBefore(date));

        return _boxFacade.save(_key, wordsByDate.toJson());
      },
    );
  }
}

extension _UsedWordsByDateSerializationExtension on UsedWordsByDate {
  UsedWordsByDateJson toJson() {
    const converter = DateTimeJsonConverter();

    return map(
      (key, value) => MapEntry(converter.toJson(key), value),
    );
  }

  static fromJson(UsedWordsByDateJson json) {
    const converter = DateTimeJsonConverter();

    return json.map(
      (key, value) => MapEntry(converter.fromJson(key), value),
    );
  }
}
