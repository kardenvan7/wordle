part of 'wordle_field.dart';

sealed class WordleFieldState {
  const WordleFieldState({
    required this.wordsFieldsStates,
  });

  final List<WordFieldState> wordsFieldsStates;

  @override
  int get hashCode => wordsFieldsStates.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! WordleFieldState) return false;
    return wordsFieldsStates.equals(other.wordsFieldsStates);
  }
}

final class NotFinishedWordleFieldState extends WordleFieldState {
  const NotFinishedWordleFieldState({
    required this.currentAttempt,
    required super.wordsFieldsStates,
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

final class FinishedWordleFieldState extends WordleFieldState {
  const FinishedWordleFieldState({
    required this.attemptsCount,
    required this.result,
    required super.wordsFieldsStates,
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
