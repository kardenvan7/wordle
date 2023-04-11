import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_statistics.freezed.dart';

@freezed
class UserStatistics with _$UserStatistics {
  const UserStatistics._();

  const factory UserStatistics({
    required int maxStreak,
    required int currentStreak,
    required Map<int, int> winsCountByAttemptNumber,
  }) = _UserStatistics;
}
