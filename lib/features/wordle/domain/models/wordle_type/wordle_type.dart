import 'package:freezed_annotation/freezed_annotation.dart';

part 'wordle_type.freezed.dart';

@freezed
abstract class WordleType with _$WordleType {
  const WordleType._();

  const factory WordleType.daily() = _$DailyWordleType;
  const factory WordleType.random({
    required int wordLength,
  }) = _$RandomWordleType;
}
