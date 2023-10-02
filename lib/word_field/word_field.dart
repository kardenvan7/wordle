import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wordle/letter_field/letter_field.dart';
import 'package:wordle/core/mixins/error_handler_mixin.dart';

part 'word_field_controller.dart';
part 'word_field_eraser.dart';
part 'word_field_shaker.dart';
part 'word_field_state.dart';
part 'word_field_validator.dart';
part 'word_field_writer.dart';

class WordField extends StatelessWidget {
  const WordField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final WordFieldListenable controller;

  @override
  Widget build(BuildContext context) {
    final letterFieldsListenables = controller.letterFieldsListenables;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        letterFieldsListenables.length,
        (index) => Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : 8),
          child: LetterField(listenable: letterFieldsListenables[index]),
        ),
      ),
    );
  }
}
