part of 'word_field.dart';

abstract interface class WordFieldEraser {
  void eraseLetter(
    List<LetterFieldController> letterFieldsControllers,
    WordFieldState state,
    VoidCallback updateState,
  );
}

class DefaultWordFieldEraser with ErrorHandlerMixin implements WordFieldEraser {
  const DefaultWordFieldEraser(this.safeMode);

  @override
  final bool safeMode;

  LetterFieldController? _getLastNonEmptyLetterController(
    List<LetterFieldController> letterFieldsControllers,
  ) {
    for (int i = letterFieldsControllers.length - 1; i >= 0; i--) {
      final controller = letterFieldsControllers[i];

      if (controller.state is FilledLetterFieldState) return controller;
    }

    return null;
  }

  @override
  void eraseLetter(
    List<LetterFieldController> letterFieldsControllers,
    WordFieldState state,
    VoidCallback updateState,
  ) {
    if (state.isValidated) {
      return handleError(
        'Can not erase letter in validated word',
      );
    }

    final controller = _getLastNonEmptyLetterController(
      letterFieldsControllers,
    );

    if (controller == null) {
      return handleError(
        'Can not erase letter in empty word field',
      );
    }

    controller.eraseLetter();
    updateState();
  }
}
