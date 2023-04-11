import 'package:wordle/core/core.dart';
import 'package:wordle/features/wordle/domain/models/wordle_type/wordle_type.dart';

abstract class UserStatisticsService {
  Future<Result<FetchFailure, UserStatisticsService>> getStatisticsForType(
    WordleType type,
  );
}
