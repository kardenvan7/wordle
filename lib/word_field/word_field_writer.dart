part of 'word_field.dart';

abstract interface class WordFieldWriter {
  void writeLetter(
    List<LetterFieldController> letterFieldsControllers,
    WordFieldState state,
    String letter,
    VoidCallback updateState,
  );
}

class DefaultWordFieldWriter with SafeModeMixin implements WordFieldWriter {
  const DefaultWordFieldWriter(this.safeMode);

  @override
  final bool safeMode;

  LetterFieldController? _getFirstEmptyLetterController(
    List<LetterFieldController> letterFieldsControllers,
  ) =>
      letterFieldsControllers.firstWhereOrNull(
        (element) => element.state is EmptyLetterFieldState,
      );

  @override
  void writeLetter(
    List<LetterFieldController> letterFieldsControllers,
    WordFieldState state,
    String letter,
    VoidCallback updateState,
  ) {
    if (state.isValidated) {
      return handleError(
        'Can not add a letter to already validated word field',
      );
    }

    final controller = _getFirstEmptyLetterController(letterFieldsControllers);

    if (controller == null) {
      return handleError(
        'Can not add a letter to fully filled word field',
      );
    }

    controller.setLetter(letter);
    updateState();
  }
}
