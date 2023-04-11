import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wordle/core/core.dart';
import 'package:wordle/features/wordle/data/providers/local/words/words_local_provider.dart';
import 'package:wordle/features/wordle/data/repositories_implementations/random_words_repository_impl.dart';

@GenerateNiceMocks([MockSpec<WordsLocalProvider>()])
import 'random_words_repository_impl_test.mocks.dart';

void main() {
  test(
    'Correctly removes excluded words from the pool',
    () async {
      final mockProvider = MockWordsLocalProvider();

      when(mockProvider.getAllWords(any)).thenAnswer(
        (realInvocation) async => Result.success(
          ['wow', 'kek', 'lol'],
        ),
      );

      final uut = RandomWordsRepositoryImpl(
        random: Random(),
        wordsLocalProvider: mockProvider,
      );

      final randomWordResult = await uut.getRandomWord(
        length: 3,
        excludedWords: ['wow', 'kek', 'lol'],
      );

      expect(
        randomWordResult,
        Result.failure(const LocalFetchFailure.notFound()),
      );
    },
  );
}
