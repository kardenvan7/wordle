import 'dart:math';

import 'package:wordle/config/configuration_variables.dart';
import 'package:wordle/core/core.dart';
import 'package:wordle/di/di.dart';
import 'package:wordle/dio/src/dio_facade.dart';
import 'package:wordle/features/app/application/cubits/locale_cubit.dart';
import 'package:wordle/features/app/application/cubits/theme_mode_cubit.dart';
import 'package:wordle/features/app/data/providers/locale/hive_locale_local_provider.dart';
import 'package:wordle/features/app/data/providers/locale/locale_local_provider.dart';
import 'package:wordle/features/app/data/providers/theme/hive_theme_mode_local_provider.dart';
import 'package:wordle/features/app/data/providers/theme/theme_mode_local_provider.dart';
import 'package:wordle/features/app/data/repositories/locale_repository_impl.dart';
import 'package:wordle/features/app/data/repositories/theme_mode_repository_impl.dart';
import 'package:wordle/features/app/domain/repositories_interfaces/locale_repository.dart';
import 'package:wordle/features/app/domain/repositories_interfaces/theme_mode_repository.dart';
import 'package:wordle/features/app/presentation/theme/theme_facade.dart';
import 'package:wordle/features/wordle/data/providers/local/used_words/used_words_local_provider.dart';
import 'package:wordle/features/wordle/data/providers/local/words/english_words_lib_words_local_provider.dart';
import 'package:wordle/features/wordle/data/providers/local/words/words_local_provider.dart';
import 'package:wordle/features/wordle/data/providers/remote/word_existence_remote_provider.dart';
import 'package:wordle/features/wordle/data/repositories_implementations/random_words_repository_impl.dart';
import 'package:wordle/features/wordle/data/repositories_implementations/used_words_repository_impl.dart';
import 'package:wordle/features/wordle/data/repositories_implementations/word_existence_repository_impl.dart';
import 'package:wordle/features/wordle/domain/repositories_interfaces/word_existence_repository.dart';
import 'package:wordle/features/wordle/domain/repositories_interfaces/words_repository.dart';
import 'package:wordle/features/wordle/domain/services/random_wordle_words_service.dart';
import 'package:wordle/features/wordle/domain/services/word_validator_service.dart';
import 'package:wordle/hive/hive.dart';
import 'package:wordle/localization/localization.dart';
import 'package:wordle/navigation/app_router.dart';

class DiInitializer {
  Future<void> initialize({bool isTest = false}) async {
    final diImpl = await _initializeImplementation(isTest: isTest);

    DI.setImplementation(diImpl);
  }

  Future<DI> _initializeImplementation({bool isTest = false}) async {
    final DI di = GetItDi.instance;

    await _initializeAppScope(di, isTest: isTest);
    await _initializeWordleScope(di, isTest: isTest);

    return di;
  }

  Future<void> _initializeAppScope(DI di, {bool isTest = false}) {
    di

      /// App
      ///
      ..registerSingleton<ConfigurationVariables>(
        Scope.app,
        DebugConfigurationVariables(),
      )
      ..registerSingleton<AppRouter>(
        Scope.app,
        BeamerAppRouter(),
      )
      ..registerSingleton<AppLogger>(
        Scope.app,
        AppLogger(),
      )
      ..registerSingleton<AppLocalizationsFacade>(
        Scope.app,
        AppLocalizationsFacade(),
      )
      ..registerSingleton<ThemeFacade>(
        Scope.app,
        ThemeFacade(),
      )

      /// App - Data

      ..registerSingletonAsync<HiveFacade>(
        Scope.app,
        () async {
          final instance = isTest ? MockHiveFacade() : HiveFacadeImpl();

          await instance.initialize();

          return instance;
        },
      )
      ..registerSingletonAsync<ThemeModeLocalProvider>(
        Scope.app,
        () async {
          final box = await di
              .get<HiveFacade>(
                Scope.app,
              )
              .openBox<String>('theme_mode');

          return HiveThemeModeLocalProvider(hiveBoxFacade: box);
        },
        dependsOn: [HiveFacade],
      )
      ..registerSingletonAsync<LocaleLocalProvider>(
        Scope.app,
        () async {
          final box =
              await di.get<HiveFacade>(Scope.app).openBox<String>('locale');

          return HiveLocaleLocalProvider(hiveBoxFacade: box);
        },
        dependsOn: [HiveFacade],
      )

      /// App - Application

      /// App - Repositories

      ..registerSingletonWithDependencies<ThemeModeRepository>(
        Scope.app,
        () => ThemeModeRepositoryImpl(
          localProvider: di.get<ThemeModeLocalProvider>(Scope.app),
        ),
        dependsOn: [ThemeModeLocalProvider],
      )
      ..registerSingletonWithDependencies<LocaleRepository>(
        Scope.app,
        () => LocaleRepositoryImpl(
          localProvider: di.get<LocaleLocalProvider>(Scope.app),
        ),
        dependsOn: [LocaleLocalProvider],
      )

      /// App - Cubits

      ..registerSingletonAsync<ThemeModeCubit>(
        Scope.app,
        () async {
          final instance = ThemeModeCubit(
            repository: di.get<ThemeModeRepository>(Scope.app),
          );

          await instance.setSavedThemeMode();

          return instance;
        },
        dependsOn: [ThemeModeRepository],
      )
      ..registerSingletonAsync<LocaleCubit>(
        Scope.app,
        () async {
          final instance = LocaleCubit(
            supportedLocales:
                di.get<AppLocalizationsFacade>(Scope.app).supportedLocales,
            repository: di.get<LocaleRepository>(Scope.app),
          );

          await instance.setSavedLocale();

          return instance;
        },
        dependsOn: [LocaleRepository],
      );

    return di.scopeReady(Scope.app);
  }

  Future<void> _initializeWordleScope(DI di, {bool isTest = false}) {
    di

      /// Wordle - Providers
      ..registerSingletonWithDependencies<WordExistenceRemoteProvider>(
        Scope.wordle,
        () {
          final config =
              di.get<ConfigurationVariables>(Scope.wordle).restApiConfiguration;

          return RapidApiWordExistenceRemoteProvider(
            dio: DioFacade(
              connectTimeout: config.connectionTimeout.value,
              receiveTimeout: config.receiveTimeout.value,
            ),
          );
        },
      )
      ..registerSingletonAsync<UsedWordsLocalProvider>(
        Scope.wordle,
        () async => HiveUsedWordsLocalProvider(
          boxFacade: await di.get<HiveFacade>(Scope.app).openBox('used_words'),
        ),
      )
      ..registerSingleton<WordsLocalProvider>(
        Scope.wordle,
        const EnglishWordsLibWordsLocalProvider(),
      )

      /// Wordle - Repositories

      ..registerSingleton<WordExistenceRepository>(
        Scope.wordle,
        WordExistenceRepositoryImpl(),
      )
      ..registerSingleton<RandomWordsRepository>(
        Scope.wordle,
        RandomWordsRepositoryImpl(
          wordsLocalProvider: di.get<WordsLocalProvider>(Scope.wordle),
          random: Random(),
        ),
      )
      ..registerSingletonWithDependencies<UsedWordsRepository>(
        Scope.wordle,
        () => UsedWordsRepositoryImpl(
          expirationDuration: di
              .get<ConfigurationVariables>(Scope.app)
              .wordleConfiguration
              .usedWordsExpirationDuration
              .value,
          localProvider: di.get<UsedWordsLocalProvider>(Scope.wordle),
        ),
        dependsOn: [UsedWordsLocalProvider],
      )

      /// Wordle - Domain
      ///
      ..registerSingleton<WordValidationService>(
        Scope.wordle,
        WordValidatorServiceImpl(
          wordExistenceRepository:
              di.get<WordExistenceRepository>(Scope.wordle),
        ),
      )
      ..registerSingletonWithDependencies<RandomWordleWordsService>(
        Scope.wordle,
        () => RandomWordleWordsServiceImpl(
          wordsRepository: di.get<RandomWordsRepository>(Scope.wordle),
          usedWordsRepository: di.get<UsedWordsRepository>(Scope.wordle),
        ),
        dependsOn: [UsedWordsRepository],
      );

    return di.scopeReady(Scope.wordle);
  }
}
