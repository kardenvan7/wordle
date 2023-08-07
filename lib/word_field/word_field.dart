import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wordle/extensions/list_extensions.dart';
import 'package:wordle/letter_field/letter_field.dart';
import 'package:wordle/mixins/safe_mode_mixin.dart';

part 'word_field_controller.dart';
part 'word_field_eraser.dart';
part 'word_field_shaker.dart';
part 'word_field_state.dart';
part 'word_field_validator.dart';
part 'word_field_writer.dart';

class WordField extends StatelessWidget {
  const WordField({
    required this.wordFieldController,
    Key? key,
  }) : super(key: key);

  final WordFieldController wordFieldController;

  _WordFieldControllerImpl get _controller =>
      wordFieldController as _WordFieldControllerImpl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _controller.letterFieldsControllers.length,
        (index) => Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : 8),
          child: LetterField(
            controller: _controller.letterFieldsControllers[index],
          ),
        ),
      ),
    );
  }
}
