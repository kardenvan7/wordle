import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wordle/extensions/list_extensions.dart';
import 'package:wordle/mixins/safe_mode_mixin.dart';
import 'package:wordle/word_field/word_field.dart';

part 'wordle_field_controller.dart';
part 'wordle_field_state.dart';

class WordleField extends StatelessWidget {
  const WordleField({
    required this.wordleFieldController,
    super.key,
  });

  final WordleFieldController wordleFieldController;

  _WordleFieldControllerImpl get _controller =>
      wordleFieldController as _WordleFieldControllerImpl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        _controller.wordFieldControllers.length,
        (index) {
          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0 : 8.0),
            child: WordField(
              wordFieldController: _controller.wordFieldControllers[index],
            ),
          );
        },
      ),
    );
  }
}
