import 'package:flutter/material.dart';
import 'package:wordle/core/widgets/stream_listener.dart';
import 'package:wordle/mixins/event_stream_mixin.dart';
import 'package:wordle/mixins/safe_mode_mixin.dart';

part 'letter_field_controller.dart';
part 'letter_field_shaker.dart';
part 'letter_field_state.dart';

class LetterField extends StatelessWidget {
  const LetterField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final LetterFieldController controller;

  void _onEvent(BuildContext context, LetterFieldEvent event) {
    switch (event) {
      case ShakeLetterFieldEvent():
        _onShakeEvent(event);
    }
  }

  void _onShakeEvent(ShakeLetterFieldEvent event) {
    debugPrint('Shake event triggered');
  }

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
    return StreamListener<LetterFieldEvent>(
      stream: controller.eventStream,
      listener: _onEvent,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final state = controller.state;

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
      ),
    );
  }
}
