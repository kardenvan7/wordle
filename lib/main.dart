import 'package:flutter/material.dart';
import 'package:wordle/di/di.dart';
import 'package:wordle/features/app/presentation/wordle.dart';

void main() {
  AppInitializer().initialize();
}

class AppInitializer {
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initDependencyInjection();

    runApp(const Wordle());
  }

  /// Initializes dependency injection classes for all scopes.
  ///
  /// Initializes dependency injection scopes.
  ///
  Future<void> _initDependencyInjection() async {
    final initializer = DiInitializer();
    await initializer.initialize();
  }
}
