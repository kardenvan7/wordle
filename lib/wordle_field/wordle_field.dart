import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wordle/core/mixins/error_handler_mixin.dart';
import 'package:wordle/word_field/word_field.dart';

part 'wordle_field_controller.dart';
part 'wordle_field_state.dart';

class WordleField extends StatelessWidget {
  const WordleField({
    required this.controller,
    super.key,
  });

  final WordleFieldListenable controller;

  @override
  Widget build(BuildContext context) {
    final wordFieldsListenables = controller.wordFieldsListenables;

    return Column(
      children: List.generate(
        wordFieldsListenables.length,
        (index) => Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 8.0),
          child: WordField(controller: wordFieldsListenables[index]),
        ),
      ),
    );
  }
}
