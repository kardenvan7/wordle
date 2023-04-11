import 'package:flutter_test/flutter_test.dart';
import 'package:wordle/di/di.dart';
import 'package:wordle/localization/localization.dart';

void main() {
  test(
    'DiInitializer initializes correctly',
    () async {
      final uut = DiInitializer();

      bool error = false;

      try {
        await uut.initialize(isTest: true);

        DI.instance.get<AppLocalizationsFacade>(Scope.wordle);
      } catch (e, st) {
        error = true;
      }

      expect(
        error,
        true,
        reason:
            'AppLocalizationsFacade is not initialized in Scope.wordle scope',
      );
    },
  );
}
