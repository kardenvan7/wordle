import 'dart:async';

import 'package:get_it/get_it.dart';

export 'src/di_initializer.dart';
export 'src/scope.dart';

abstract class DI {
  static DI get instance {
    assert(
      _implementation != null,
      'DI implementation is not set. Use DI.setImplementation method.',
    );

    return _implementation!;
  }

  static DI? _implementation;

  static void setImplementation(DI implementation) {
    _implementation = implementation;
  }

  T get<T extends Object>(Scope scope);

  void registerSingleton<T extends Object>(Scope scope, T instance);

  void registerFactory<T extends Object>(
    Scope scope,
    T Function() instanceFactory,
  );

  void registerFactoryAsync<T extends Object>(
    Scope scope,
    Future<T> Function() instanceAsyncFactory,
  );

  void registerSingletonAsync<T extends Object>(
    Scope scope,
    Future<T> Function() singletonAsyncFactory, {
    Iterable<Type>? dependsOn,
  });

  void registerSingletonWithDependencies<T extends Object>(
    Scope scope,
    T Function() singletonFactory, {
    Iterable<Type>? dependsOn,
  });

  FutureOr<void> unregister<T extends Object>(Scope scope);

  Future<void> scopeReady(Scope scope);

  Future<void> allScopesReady();
}

enum Scope {
  app,
  wordle;
}

class GetItDi implements DI {
  GetItDi._();

  static final GetItDi instance = GetItDi._();

  final Map<Scope, GetIt> _getItByScope = {
    for (final scope in Scope.values) scope: GetIt.asNewInstance(),
  };

  @override
  T get<T extends Object>(Scope scope) {
    return _getItForScope(scope)<T>();
  }

  @override
  void registerSingleton<T extends Object>(Scope scope, T instance) {
    return _getItForScope(scope).registerSingleton<T>(instance);
  }

  @override
  void registerFactory<T extends Object>(
    Scope scope,
    T Function() instanceFactory,
  ) {
    return _getItForScope(scope).registerFactory<T>(instanceFactory);
  }

  @override
  void registerFactoryAsync<T extends Object>(
    Scope scope,
    Future<T> Function() instanceAsyncFactory,
  ) {
    return _getItForScope(scope).registerFactoryAsync<T>(instanceAsyncFactory);
  }

  @override
  void registerSingletonAsync<T extends Object>(
    Scope scope,
    Future<T> Function() singletonAsyncFactory, {
    Iterable<Type>? dependsOn,
  }) {
    return _getItForScope(scope).registerSingletonAsync<T>(
      singletonAsyncFactory,
      dependsOn: dependsOn,
    );
  }

  @override
  void registerSingletonWithDependencies<T extends Object>(
    Scope scope,
    T Function() singletonFactory, {
    Iterable<Type>? dependsOn,
  }) {
    return _getItForScope(scope).registerSingletonWithDependencies<T>(
      singletonFactory,
      dependsOn: dependsOn,
    );
  }

  @override
  FutureOr<void> unregister<T extends Object>(Scope scope) {
    return _getItForScope(scope).unregister<T>();
  }

  @override
  Future<void> scopeReady(Scope scope) {
    return _getItForScope(scope).allReady();
  }

  @override
  Future<void> allScopesReady() {
    return Future.wait(_getItByScope.values.map((e) => e.allReady()));
  }

  GetIt _getItForScope(Scope scope) {
    return _getItByScope[scope]!;
  }
}
