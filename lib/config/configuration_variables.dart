import 'package:flutter/foundation.dart';

import 'env.dart';

abstract class ConfigurationVariables {
  ConfigurationVariables({
    required RestApiConfiguration initialRestApiConfiguration,
    required this.env,
    required this.wordleConfiguration,
  }) : restApiConfiguration = initialRestApiConfiguration;

  /// REST API
  final RestApiConfiguration restApiConfiguration;

  /// Environmental variables
  final Env env;

  /// Wordle
  final WordleConfiguration wordleConfiguration;
}

class DebugConfigurationVariables extends ConfigurationVariables {
  DebugConfigurationVariables()
      : super(
          initialRestApiConfiguration: RestApiConfiguration(
            fakeInternetConnectionAbsence: false,
            enableDioLogging: true,
            connectionTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
          ),
          env: DevEnv(),
          wordleConfiguration: WordleConfiguration(
            usedWordsExpirationDuration: const Duration(minutes: 1),
          ),
        );
}

class ProductionConfigurationVariables extends ConfigurationVariables {
  ProductionConfigurationVariables()
      : super(
          initialRestApiConfiguration: RestApiConfiguration(
            fakeInternetConnectionAbsence: false,
            enableDioLogging: false,
            connectionTimeout: const Duration(seconds: 7),
            receiveTimeout: const Duration(seconds: 7),
          ),
          env: ProdEnv(),
          wordleConfiguration: WordleConfiguration(
            usedWordsExpirationDuration: const Duration(days: 180),
          ),
        );
}

class RestApiConfiguration {
  RestApiConfiguration({
    required bool fakeInternetConnectionAbsence,
    required bool enableDioLogging,
    required Duration connectionTimeout,
    required Duration receiveTimeout,
  })  : _enableDioLogging = ValueNotifier(enableDioLogging),
        _fakeInternetConnectionAbsence = ValueNotifier(
          fakeInternetConnectionAbsence,
        ),
        _connectionTimeout = ValueNotifier(connectionTimeout),
        _receiveTimeout = ValueNotifier(receiveTimeout);

  final ValueNotifier<bool> _fakeInternetConnectionAbsence;
  ValueListenable<bool> get fakeInternetConnectionAbsence =>
      _fakeInternetConnectionAbsence;
  void setFakeInternetConnectionAbsence(bool value) {
    _fakeInternetConnectionAbsence.value = value;
  }

  final ValueNotifier<bool> _enableDioLogging;
  ValueListenable<bool> get enableDioLogging => _enableDioLogging;
  void setEnableDioLogging(bool value) {
    _enableDioLogging.value = value;
  }

  final ValueNotifier<Duration> _connectionTimeout;
  ValueListenable<Duration> get connectionTimeout => _connectionTimeout;
  void setConnectionTimeout(Duration duration) {
    _connectionTimeout.value = duration;
  }

  final ValueNotifier<Duration> _receiveTimeout;
  ValueListenable<Duration> get receiveTimeout => _receiveTimeout;
  void setReceiveTimeout(Duration duration) {
    _receiveTimeout.value = duration;
  }
}

class WordleConfiguration {
  WordleConfiguration({
    required Duration usedWordsExpirationDuration,
  }) : _usedWordsExpirationDuration = ValueNotifier<Duration>(
          usedWordsExpirationDuration,
        );

  final ValueNotifier<Duration> _usedWordsExpirationDuration;
  ValueListenable<Duration> get usedWordsExpirationDuration =>
      _usedWordsExpirationDuration;
  void setUsedWordsExpirationDuration(Duration duration) {
    _usedWordsExpirationDuration.value = duration;
  }
}
