import 'package:wordle/core/src/failures/failure.dart';
import 'package:wordle/core/src/result.dart';
import 'package:wordle/features/app/data/providers/theme/theme_mode_local_provider.dart';
import 'package:wordle/features/app/domain/repositories_interfaces/theme_mode_repository.dart';
import 'package:flutter/material.dart';

class ThemeModeRepositoryImpl implements ThemeModeRepository {
  const ThemeModeRepositoryImpl({
    required ThemeModeLocalProvider localProvider,
  }) : _localProvider = localProvider;

  final ThemeModeLocalProvider _localProvider;

  @override
  Future<Result<FetchFailure, ThemeMode>> getThemeMode() {
    return _localProvider.getThemeMode();
  }

  @override
  Future<Result<FetchFailure, void>> saveThemeMode(ThemeMode mode) {
    return _localProvider.saveThemeMode(mode);
  }
}
