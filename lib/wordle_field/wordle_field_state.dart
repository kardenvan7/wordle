part of 'wordle_field.dart';

sealed class WordleFieldState {}

final class NotFinishedWordleFieldState implements WordleFieldState {
  const NotFinishedWordleFieldState({
    required this.currentAttempt,
  });

  final int currentAttempt;

  @override
  int get hashCode => currentAttempt.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! NotFinishedWordleFieldState) return false;

    return currentAttempt == other.currentAttempt;
  }

  @override
  String toString() {
    return '$runtimeType(currentAttempt: $currentAttempt)';
  }
}

final class FinishedWordleFieldState implements WordleFieldState {
  const FinishedWordleFieldState({
    required this.attemptsCount,
    required this.result,
  });

  final int attemptsCount;
  final FinishedWordleFieldResult result;

  @override
  int get hashCode => attemptsCount.hashCode ^ result.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! FinishedWordleFieldState) return false;

    return attemptsCount == other.attemptsCount && result == other.result;
  }

  @override
  String toString() {
    return '$runtimeType(attemptsCount: $attemptsCount, result: $result)';
  }
}

enum FinishedWordleFieldResult {
  won,
  lost;
}
