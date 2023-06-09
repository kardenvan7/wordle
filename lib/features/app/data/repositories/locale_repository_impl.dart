import 'package:wordle/core/src/failures/failure.dart';
import 'package:wordle/core/src/result.dart';
import 'package:wordle/features/app/data/providers/locale/locale_local_provider.dart';
import 'package:wordle/features/app/domain/repositories_interfaces/locale_repository.dart';
import 'package:flutter/material.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  const LocaleRepositoryImpl({
    required LocaleLocalProvider localProvider,
  }) : _localProvider = localProvider;

  final LocaleLocalProvider _localProvider;

  @override
  Future<Result<FetchFailure, Locale>> getLocale() {
    return _localProvider.getLocale();
  }

  @override
  Future<Result<FetchFailure, void>> saveLocale(Locale locale) {
    return _localProvider.saveLocale(locale);
  }
}
