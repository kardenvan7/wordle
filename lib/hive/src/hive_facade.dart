import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:wordle/core/core.dart';

part 'hive_box_facade.dart';

abstract class HiveFacade {
  Future<void> initialize();

  Future<HiveBoxFacade<T>> openBox<T>(String key);

  HiveBoxFacade<T> getBox<T>(String name);
}

class HiveFacadeImpl implements HiveFacade {
  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    final appDir = await path_provider.getApplicationDocumentsDirectory();

    Hive.init(appDir.path);
  }

  @override
  Future<HiveBoxFacade<T>> openBox<T>(String key) async {
    return HiveBoxFacadeImpl(await Hive.openBox<T>(key));
  }

  @override
  HiveBoxFacade<T> getBox<T>(String name) {
    return HiveBoxFacadeImpl(Hive.box<T>(name));
  }
}

class MockHiveFacade implements HiveFacadeImpl {
  final Map<String, HiveBoxFacade> _openedBoxes = {};

  @override
  Future<void> initialize() async {
    // do nothing
  }

  @override
  Future<HiveBoxFacade<T>> openBox<T>(String key) async {
    final newBox = MockHiveBoxFacade<T>();
    _openedBoxes[key] = newBox;

    return newBox;
  }

  @override
  HiveBoxFacade<T> getBox<T>(String name) {
    final box = _openedBoxes[name];

    if (box == null || box.valueType is! T) {
      throw Exception(
        'Box with name "$name" and type "$T" not found. '
        'Perhaps you forgot to call HiveFacade.openBox<$T>("$name").',
      );
    }

    return box as HiveBoxFacade<T>;
  }
}
