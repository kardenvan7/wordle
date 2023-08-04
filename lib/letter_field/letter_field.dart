import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wordle/mixins/mixin.dart';

part 'letter_field_controller.dart';
part 'letter_field_state.dart';

class LetterField extends StatefulWidget {
  const LetterField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final LetterFieldController controller;

  @override
  State<LetterField> createState() => _LetterFieldState();
}

class _LetterFieldState extends State<LetterField> {
  late final LetterFieldController _fieldController = widget.controller;

  Color? _getColorByState(LetterFieldState state) {
    final color = switch (state) {
      EmptyLetterFieldState() => null,
      FilledLetterFieldState(validationStatus: final status) => switch (
            status) {
          LetterValidationStatus.notValidated => null,
          LetterValidationStatus.absent => Colors.redAccent,
          LetterValidationStatus.wrongPlacement => Colors.yellowAccent,
          LetterValidationStatus.correct => Colors.greenAccent,
        },
    };

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LetterFieldState>(
      valueListenable: _fieldController.listenable,
      builder: (context, state, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          decoration: BoxDecoration(
            color: _getColorByState(state),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black, width: 2),
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: 24,
            child: Text(
              switch (state) {
                EmptyLetterFieldState() => '',
                FilledLetterFieldState(letter: String text) => text,
              },
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
